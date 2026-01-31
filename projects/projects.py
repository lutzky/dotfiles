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

def parse_metadata_optimized2(filepath):
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
          # We only care about these 3 keys, skip others
          if k in ('status', 'priority', 'snooze_until'):
            data[k] = v.strip().strip('"').strip("'")
      return data
  except Exception:
    return None

def parse_metadata_optimized(filepath):
  """
  Reads only the preamble. Returns metadata dict or None
   if no preamble exists.
  """
  data = {}
  try:
    with open(filepath, 'r', encoding='utf-8') as f:
      first_line = f.readline().strip()
      if first_line != '---':
        return None  # Not a frontmatter file, skip immediately

      for line in f:
        line = line.strip()
        if line == '---':
          return data # End of preamble reached, stop reading

        if ':' in line:
          key, val = line.split(':', 1)
          data[key.strip().lower()] = val.strip().strip('"').strip("'")
  except Exception:
    return None
  return data # Fallback if file ends before second ---

def get_priority_display(prio):
  mapping = {"P0": "🟥 P0", "P1": "🟨 P1", "P2": "🟩 P2"}
  return mapping.get(prio.upper(), f"⬜ {prio.upper()}")

def main():
  today = datetime.now().strftime('%Y-%m-%d')
  projects = []
  snoozed_projects = []
  invalid_statuses = []

  for root, _, files in os.walk('.'):
    for filename in files:
      if filename.endswith(".md"):
        filepath = os.path.join(root, filename)
        meta = parse_metadata_optimized2(filepath)

        if not meta:
          continue

        page_name = os.path.splitext(filename)[0]
        page_link = f"[[{page_name}]]"
        status = meta.get('status', '')
        snooze = meta.get('snooze_until')
        priority = meta.get('priority', 'P99')

        if status == "Active" and (not snooze or snooze <= today):
          projects.append({
            'link': page_link,
            'priority_raw': priority.upper(),
            'priority_display': get_priority_display(priority)
          })
        elif status == "Active":
          snoozed_projects.append({
            'snooze': snooze,
            'link': page_link,
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

  output = subprocess.run(["rg", "--type", "markdown", "\[ \].*#next"], capture_output=True)
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

  print("# Active Projects")
  for p in projects:
    print(f"{p['priority_display']} {p['link']}")

  print("\n# Snoozed")
  for p in snoozed_projects[:10]:
    print(f"😴{p['snooze']} {p['priority_display']} {p['link']}")
  if len(snoozed_projects) > 10:
    print("...and more")
    # TODO: How to display more?

if __name__ == "__main__":
  main()
