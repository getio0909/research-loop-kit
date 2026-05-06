#!/usr/bin/env bash
set -eu

root="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"

required_files="
AGENTS.md
README.md
README.zh-CN.md
docs/design-principles.md
docs/reference-notes.md
templates/RESEARCH_BRIEF.template.md
templates/ITERATION_REPORT.template.md
templates/EVIDENCE_NOTE.template.md
templates/EXPERIMENT_CARD.template.md
templates/PROVENANCE.template.md
skills/run-research-iteration/SKILL.md
examples/RESEARCH_BRIEF.example.md
"

for file in $required_files; do
  if [ ! -f "$root/$file" ]; then
    echo "missing: $file" >&2
    exit 1
  fi
done

if ! grep -q '^# ResearchLoop Kit' "$root/README.md"; then
  echo "README.md missing project title" >&2
  exit 1
fi

if ! grep -q '^# ResearchLoop Kit' "$root/README.zh-CN.md"; then
  echo "README.zh-CN.md missing project title" >&2
  exit 1
fi

if ! grep -q '^---$' "$root/skills/run-research-iteration/SKILL.md"; then
  echo "skill frontmatter missing" >&2
  exit 1
fi

if grep -RInE 'TBD|TODO|FIXME' "$root" --exclude-dir=.git --exclude='verify.sh'; then
  echo "placeholder text found" >&2
  exit 1
fi

tmp="/tmp/research-loop-kit-nonascii.$$"
: > "$tmp"
while IFS= read -r -d '' file; do
  if LC_ALL=C grep -n '[^ -~[:space:]]' "$file" >> "$tmp"; then
    :
  fi
done < <(find "$root" -path "$root/.git" -prune -o -type f \
  ! -path "$root/README.zh-CN.md" \
  ! -path "$root/scripts/verify.sh" \
  -print0)

if [ -s "$tmp" ]; then
  cat "$tmp" >&2
  rm -f "$tmp"
  echo "non-ASCII text found outside README.zh-CN.md" >&2
  exit 1
fi
rm -f "$tmp"

echo "ResearchLoop Kit structure OK"
