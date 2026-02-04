#!/usr/bin/env python3

import os
import subprocess
import sys
from datetime import datetime

VALID_STATUSES = [
  'Active',
  'Done',
  'Decided no',
  'Ready',
]

if not os.path.exists("index.md"):
  print("index.md not found, this is probably not a project dir")
  sys.exit(1)

def get_inbox_notes():
  result = []
  for root, _, files in os.walk('Inbox'):
    for filename in files:
      if not filename.endswith(".md"):
        continue
      full_path = os.path.join(root,filename)
      path_for_link = os.path.splitext(full_path)[0]
      link = f"[[{path_for_link}]]"

      with open(full_path) as f:
        first_line = f.readline().strip()
      result.append((link,first_line))
  return result

def parse_metadata_optimized(filepath):
  try:
    with open(filepath, 'r', encoding='utf-8') as f:
      # Use local variable for faster access
      readline = f.readline

      first_line = readline()
      if first_line[:3] != '---': # Slice check is slightly faster than strip
        return None

      data = {}
      for line in f:
        if line[:3] == '---':
          return data

        if ':' in line:
          # Only strip/lower once we find the delimiter
          k, v = line.split(':', 1)
          k = k.strip().lower()
          # We only care about these keys, skip others
          # cSpell: ignore pagedecoration
          if k in ('status', 'priority', 'snooze_until',
                   'pagedecoration.prefix', 'hide_if_snoozed'):
            data[k] = v.strip().strip('"').strip("'")
      return data
  except Exception:
    return None

def get_priority_display(priority):
  mapping = {"P0": "🟥P0", "P1": "🟨P1", "P2": "🟩P2"}
  return mapping.get(priority.upper(), f"⬜{priority.upper()}")

def main():
  today = datetime.now().strftime('%Y-%m-%d')
  projects = []
  snoozed_projects = []
  invalid_statuses = []

  for root, _, files in os.walk('Projects'):
    for filename in files:
      if filename.endswith(".md"):
        filepath = os.path.join(root, filename)
        meta = parse_metadata_optimized(filepath)

        if not meta:
          continue

        page_name = os.path.join(root,os.path.splitext(filename)[0])
        page_link = f"[[{page_name}]]"
        status = meta.get('status', '')
        snooze = meta.get('snooze_until')
        is_snoozed = snooze and snooze > today
        hide_if_snoozed = meta.get('hide_if_snoozed', 'false').lower() != 'false'
        priority = meta.get('priority', 'P99')
        page_icon = meta.get('pagedecoration.prefix', '')

        if hide_if_snoozed and status != "Active":
            print(f"⚠️ WARNING: {page_link} has useless hide_if_snoozed")

        if status == "Active" and not is_snoozed:
          projects.append({
            'link': page_link,
            'icon': page_icon,
            'priority_raw': priority.upper(),
            'priority_display': get_priority_display(priority)
          })
        elif status == "Active" and not hide_if_snoozed:
            snoozed_projects.append({
              'snooze': snooze,
              'link': page_link,
              'icon': page_icon,
              'priority_raw': priority.upper(),
              'priority_display': get_priority_display(priority)
            })
        elif status not in VALID_STATUSES:
          invalid_statuses.append({
            'link': page_link,
            'status': status,
          })

  # Sort P0 -> P1 -> P2 -> Others
  projects.sort(key=lambda x: x['priority_raw'])
  snoozed_projects.sort(key=lambda x: (x['snooze'], x['priority_raw']))

  if invalid_statuses:
    print("# Invalid status pages")
    print("Status is not one of", VALID_STATUSES)
    for page in invalid_statuses:
      print(page['link'], page['status'])

  inbox_notes = get_inbox_notes()
  if inbox_notes:
    print("# Inbox notes")
    for link, first_line in inbox_notes:
      print(link, first_line)
    print()

  output = subprocess.run(["rg", "--type", "markdown", "\\[ \\].*#next"], capture_output=True)
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
    print(f"{p['priority_display']} {p['icon']}{p['link']}")

  print(f"\n# Snoozed ({len(snoozed_projects)})")
  for p in snoozed_projects[:10]:
    print(f"😴{p['snooze']} {p['priority_display']} {p['icon']}{p['link']}")
  if len(snoozed_projects) > 10:
    print("...and more")
    # TODO: How to display more?

if __name__ == "__main__":
  main()
