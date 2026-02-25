#!/usr/bin/env python3

import os
import subprocess
import sys
import yaml
from datetime import datetime

VALID_STATUSES = [
    "Active",
    "Done",
    "Decided no",
    "Ready",
]

SNOOZED_LIMIT = 10


def get_inbox_notes():
    result = []
    for root, _, files in os.walk("Inbox"):
        for filename in files:
            if not filename.endswith(".md"):
                continue
            full_path = os.path.join(root, filename)
            path_for_link = os.path.splitext(full_path)[0]
            link = f"[[{path_for_link}]]"

            with open(full_path) as f:
                first_line = f.readline().strip()
            result.append((link, first_line))
    return result


def parse_metadata(filepath):
    try:
        with open(filepath, "r", encoding="utf-8") as f:
            lines = []
            first_line = f.readline()
            if first_line[:3] != "---":
                return None

            for line in f:
                if line[:3] == "---":
                    return yaml.safe_load("".join(lines))
                lines.append(line)

            return {}
    except Exception:
        return None


def get_priority_display(priority):
    mapping = {"P0": "🟥P0", "P1": "🟨P1", "P2": "🟩P2"}
    return mapping.get(priority.upper(), f"⬜{priority.upper()}")


def print_project(p, show_snooze=False):
    if show_snooze:
        print(f"😴{p['snooze']} ", end="")
    parts = [p['priority_display'],p['link'],p['icon'],p['tags']]
    print(" " .join([part for part in parts if part]))


def main():
    if not os.path.exists("index.md"):
        print("index.md not found, this is probably not a project dir")
        sys.exit(1)

    today = datetime.now().strftime("%Y-%m-%d")
    projects = []
    snoozed_projects = []
    ready_projects = []
    invalid_statuses = []

    for root, _, files in os.walk("Projects"):
        for filename in files:
            if not filename.endswith(".md"):
                continue
            filepath = os.path.join(root, filename)
            meta = parse_metadata(filepath)

            if not meta:
                continue

            page_name = os.path.join(root, os.path.splitext(filename)[0])
            page_link = f"[[{page_name}]]"
            status = meta.get("status", "")
            snooze: datetime = meta.get("snooze_until")  # type: ignore
            is_snoozed = snooze and snooze.strftime("%Y-%m-%d") > today
            hide_if_snoozed = meta.get("hide_if_snoozed", False)
            priority = meta.get("priority", "P9")
            page_icon = meta.get("pageDecoration.prefix", "")
            page_tags = " ".join(f"#{t}" for t in meta.get("tags", []) or [])

            if hide_if_snoozed and status != "Active":
                print(f"⚠️ WARNING: {page_link} has useless hide_if_snoozed")

            if status == "Active" and not is_snoozed:
                projects.append(
                    {
                        "link": page_link,
                        "icon": page_icon,
                        "tags": page_tags,
                        "priority_raw": priority.upper(),
                        "priority_display": get_priority_display(priority),
                    }
                )
            elif status == "Active" and not hide_if_snoozed:
                snoozed_projects.append(
                    {
                        "snooze": snooze,
                        "link": page_link,
                        "tags": page_tags,
                        "icon": page_icon,
                        "priority_raw": priority.upper(),
                        "priority_display": get_priority_display(priority),
                    }
                )
            elif status == "Ready":
                ready_projects.append(
                    {
                        "link": page_link,
                        "icon": page_icon,
                        "tags": page_tags,
                        "priority_raw": priority.upper(),
                        "priority_display": get_priority_display(priority),
                    }
                )
            elif status not in VALID_STATUSES:
                invalid_statuses.append(
                    {
                        "link": page_link,
                        "status": status,
                    }
                )

    # Sort P0 -> P1 -> P2 -> Others
    projects.sort(key=lambda x: x["priority_raw"])
    ready_projects.sort(key=lambda x: x["priority_raw"])
    snoozed_projects.sort(key=lambda x: (x["snooze"], x["priority_raw"]))

    if invalid_statuses:
        print("# Invalid status pages")
        print("Status is not one of", VALID_STATUSES)
        for page in invalid_statuses:
            print(page["link"], page["status"])

    inbox_notes = get_inbox_notes()
    if inbox_notes:
        print("# Inbox notes")
        for link, first_line in inbox_notes:
            print(link, first_line)
        print()

    output = subprocess.run(
        ["rg", "--type", "markdown", "\\[ \\].*#next"], capture_output=True
    )
    next_lines = output.stdout.decode("utf-8").splitlines()
    if len(next_lines) == 0:
        print("No open tasks tagged #next")
    else:
        print("# Open tasks tagged #next")
        for line in next_lines[:10]:
            filename, rest = line.strip().split(":", 1)
            link = f"[[{os.path.splitext(filename)[0]}]]"
            print(link, rest)
        if len(next_lines) > 10:
            print("...more...")

    print()

    print(f"# Active ({len(projects)})")
    for p in projects:
        print_project(p)

    print(f"\n# Snoozed ({len(snoozed_projects)})")
    for p in snoozed_projects[:SNOOZED_LIMIT]:
        print_project(p, show_snooze=True)
    if len(snoozed_projects) > SNOOZED_LIMIT:
        print("...see more below")

    print(f"\n# Ready ({len(ready_projects)})")
    for p in ready_projects:
        print_project(p)

    if len(snoozed_projects) > SNOOZED_LIMIT:
        print(f"\n# More Snoozed ({SNOOZED_LIMIT}..{len(snoozed_projects)})")
        for p in snoozed_projects[SNOOZED_LIMIT:]:
            print_project(p, show_snooze=True)

    print("\nConsider grepping for `hide_if_snoozed`, `Decided no`.")


if __name__ == "__main__":
    main()
