#!/usr/bin/env python3

import io
import os
import subprocess
import sys
import yaml
from dataclasses import dataclass
from datetime import datetime
from typing import Optional


@dataclass
class Project:
    link: str
    icon: str
    tags: str
    priority_raw: str
    priority_display: str
    snooze: Optional[datetime] = None
    status: str = ""
    hide_if_snoozed: bool = False


VALID_STATUSES = frozenset(["Active", "Done", "Decided no", "Ready"])

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


def parse_metadata(filepath: str) -> dict:
    try:
        with open(filepath, "r", encoding="utf-8") as f:
            lines = []
            first_line = f.readline()
            if first_line[:3] != "---":
                return {}

            for line in f:
                if line[:3] == "---":
                    return yaml.safe_load(io.StringIO("".join(lines))) or {}
                lines.append(line)

            return {}
    except Exception:
        return {}


def get_priority_display(priority: str) -> str:
    mapping = {"P0": "🟥P0", "P1": "🟨P1", "P2": "🟩P2"}
    return mapping.get(priority.upper(), f"⬜{priority.upper()}")


def load_projects() -> list[Project]:
    projects: list[Project] = []
    for root, _, files in os.walk("Projects"):
        for filename in files:
            if not filename.endswith(".md"):
                continue
            filepath = os.path.join(root, filename)
            meta = parse_metadata(filepath)

            page_name = os.path.join(root, os.path.splitext(filename)[0])
            page_link = f"[[{page_name}]]"
            status: str = meta.get("status", "")
            snooze: Optional[datetime] = meta.get("snooze_until")
            hide_if_snoozed: bool = meta.get("hide_if_snoozed", False)
            priority: str = meta.get("priority", "P9")
            page_icon: str = meta.get("pageDecoration.prefix", "")
            page_tags: str = " ".join(f"#{t}" for t in meta.get("tags", []) or [])

            priority_raw = priority.upper()
            projects.append(
                Project(
                    link=page_link,
                    icon=page_icon,
                    tags=page_tags,
                    priority_raw=priority_raw,
                    priority_display=get_priority_display(priority),
                    snooze=snooze,
                    status=status,
                    hide_if_snoozed=hide_if_snoozed,
                )
            )
    return projects


def print_project(p: Project, show_snooze: bool = False) -> None:
    if show_snooze and p.snooze:
        print(f"😴{p.snooze} ", end="")
    parts = [p.priority_display, p.link, p.icon, p.tags]
    print(" ".join([part.strip() for part in parts if part]))


def main() -> None:
    if not os.path.exists("index.md"):
        print("index.md not found, this is probably not a project dir")
        sys.exit(1)

    today = datetime.now().strftime("%Y-%m-%d")
    all_projects = load_projects()

    valid_projects = [p for p in all_projects if p.status in VALID_STATUSES]

    def is_snoozed(p: Project) -> bool:
        return bool(p.snooze and p.snooze.strftime("%Y-%m-%d") > today)

    invalid_status_pages = [p for p in all_projects if p.status not in VALID_STATUSES]
    useless_hide_if_snoozed = [p for p in all_projects if p.hide_if_snoozed and p.status != "Active"]

    if invalid_status_pages:
        print("# Invalid status pages")
        print("Status is not one of", VALID_STATUSES)
        for p in invalid_status_pages:
            print(p.link, p.status)

    if useless_hide_if_snoozed:
        print("# Useless hide_if_snoozed")
        print("hide_if_snoozed is only useful when status is Active")
        for p in useless_hide_if_snoozed:
            print(p.link, p.status)

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

    active = sorted(
        [p for p in valid_projects if p.status == "Active" and not is_snoozed(p)],
        key=lambda x: x.priority_raw,
    )
    print(f"# Active ({len(active)})")
    for p in active:
        print_project(p)

    snoozed = sorted(
        [p for p in valid_projects if p.status == "Active" and is_snoozed(p) and not p.hide_if_snoozed],
        key=lambda x: (x.snooze, x.priority_raw),
    )
    print(f"\n# Snoozed ({len(snoozed)})")
    for p in snoozed[:SNOOZED_LIMIT]:
        print_project(p, show_snooze=True)
    if len(snoozed) > SNOOZED_LIMIT:
        print("...see more below")

    ready = sorted(
        [p for p in valid_projects if p.status == "Ready"],
        key=lambda x: x.priority_raw,
    )
    print(f"\n# Ready ({len(ready)})")
    for p in ready:
        print_project(p)

    if len(snoozed) > SNOOZED_LIMIT:
        print(f"\n# More Snoozed ({SNOOZED_LIMIT}..{len(snoozed)})")
        for p in snoozed[SNOOZED_LIMIT:]:
            print_project(p, show_snooze=True)

    print("\nConsider grepping for `hide_if_snoozed`, `Decided no`.")


if __name__ == "__main__":
    main()
