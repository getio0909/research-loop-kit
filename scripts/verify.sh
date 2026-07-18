#!/usr/bin/env bash
set -euo pipefail

root="$(cd -- "$(dirname -- "$0")/.." >/dev/null 2>&1 && pwd -P)"

fail() {
	printf 'verify: %s\n' "$*" >&2
	exit 1
}

required_files=(
	.github/workflows/verify.yml
	.gitignore
	AGENTS.md
	CHANGELOG.md
	CONTRIBUTING.md
	LICENSE
	README.md
	README.zh-CN.md
	docs/design-principles.md
	docs/reference-notes.md
	examples/RESEARCH_BRIEF.example.md
	scripts/verify.sh
	skills/init-research-project/SKILL.md
	skills/run-research-iteration/SKILL.md
	templates/EVIDENCE_NOTE.template.md
	templates/EXPERIMENT_CARD.template.md
	templates/GOAL_STATE.template.md
	templates/ITERATION_REPORT.template.md
	templates/PROVENANCE.template.md
	templates/RESEARCH_BRIEF.template.md
)

required_dirs=(
	artifacts
	docs
	examples
	skills/init-research-project
	skills/run-research-iteration
	state
	templates
)

for file in "${required_files[@]}"; do
	if [ ! -f "$root/$file" ] || [ -L "$root/$file" ]; then
		fail "missing or unsafe required file: $file"
	fi
	if [ ! -s "$root/$file" ]; then
		fail "empty required file: $file"
	fi
done

for dir in "${required_dirs[@]}"; do
	if [ ! -d "$root/$dir" ] || [ -L "$root/$dir" ]; then
		fail "missing or unsafe required directory: $dir"
	fi
done

if ! LC_ALL=C grep -q '^# ResearchLoop Kit' "$root/README.md"; then
	fail "README.md missing project title"
fi

if ! LC_ALL=C grep -q '^# ResearchLoop Kit' "$root/README.zh-CN.md"; then
	fail "README.zh-CN.md missing project title"
fi

check_skill_frontmatter() {
	local file="$1"
	local expected_name="$2"

	if ! LC_ALL=C awk -v expected_name="$expected_name" '
		NR == 1 {
			if ($0 != "---") exit 1
			next
		}
		$0 == "---" {
			closed = 1
			exit
		}
		$0 == "name: " expected_name { found_name = 1 }
		$0 ~ /^description: .+/ { found_description = 1 }
		END {
			if (!closed || !found_name || !found_description) exit 1
		}
	' "$root/$file"; then
		fail "invalid skill frontmatter: $file"
	fi
}

check_skill_frontmatter \
	"skills/init-research-project/SKILL.md" "init-research-project"
check_skill_frontmatter \
	"skills/run-research-iteration/SKILL.md" "run-research-iteration"

count_marked_phases() {
	local file="$1"

	LC_ALL=C awk '
		/<!-- research-loop-phases:start -->/ {
			if (active || seen) exit 2
			active = 1
			seen = 1
			next
		}
		/<!-- research-loop-phases:end -->/ {
			if (!active) exit 2
			active = 0
			closed = 1
			next
		}
		active && /^[0-9]+\.[[:space:]]/ { count++ }
		END {
			if (!seen || !closed || active) exit 2
			print count + 0
		}
	' "$root/$file"
}

loop_files=(
	AGENTS.md
	README.md
	README.zh-CN.md
	skills/run-research-iteration/SKILL.md
)

for file in "${loop_files[@]}"; do
	if ! phase_count="$(count_marked_phases "$file")"; then
		fail "invalid research-loop phase markers: $file"
	fi
	case "$phase_count" in
		'' | *[!0-9]*) fail "invalid research-loop phase count: $file" ;;
	esac
	if [ "$phase_count" -ne 8 ]; then
		fail "research loop must contain exactly eight phases: $file"
	fi
done

if ! LC_ALL=C grep -q '^## Goal Mode$' "$root/AGENTS.md" ||
	! LC_ALL=C grep -q '^## Evidence And Artifact Safety$' "$root/AGENTS.md"; then
	fail "AGENTS.md missing goal-mode or artifact-safety contract"
fi

for file in README.md README.zh-CN.md skills/run-research-iteration/SKILL.md; do
	if ! LC_ALL=C grep -q 'templates/GOAL_STATE.template.md' "$root/$file"; then
		fail "goal-state template is not discoverable from $file"
	fi
done

goal_contract_files=(
	AGENTS.md
	README.md
	README.zh-CN.md
	skills/run-research-iteration/SKILL.md
	templates/GOAL_STATE.template.md
)

for file in "${goal_contract_files[@]}"; do
	if ! LC_ALL=C grep -q 'stopped' "$root/$file"; then
		fail "goal contract is missing stopped status: $file"
	fi
done

if ! LC_ALL=C grep -Fxq '   codex' "$root/README.md" ||
	! LC_ALL=C grep -Fxq \
		'   claude --append-system-prompt-file AGENTS.md' "$root/README.md"; then
	fail "README.md missing supported agent launch commands"
fi

for file in README.md README.zh-CN.md; do
	if LC_ALL=C grep -Eq 'codex -p|--agent-prompt' "$root/$file"; then
		fail "obsolete agent launch command found: $file"
	fi
done

tmp_dir="$(mktemp -d "${TMPDIR:-/tmp}/research-loop-verify.XXXXXX")"
trap 'rm -rf "$tmp_dir"' EXIT HUP INT TERM
file_list="$tmp_dir/files"
matches="$tmp_dir/matches"

is_sensitive_path() {
	case "$1" in
		.env.example | */.env.example | .env.*.example | */.env.*.example)
			return 1
			;;
		.env | */.env | .env.* | */.env.* | .envrc | */.envrc | \
		.ssh/* | */.ssh/* | .aws/* | */.aws/* | .netrc | */.netrc | \
		.npmrc | */.npmrc | .pypirc | */.pypirc | *.key | *.pem | \
		*.p12 | *.pfx | *.jks | *.keystore | *.kdbx | id_rsa* | \
		*/id_rsa* | id_ed25519* | */id_ed25519* | credentials.json | \
		*/credentials.json | .codex/auth.json | */.codex/auth.json | \
		.codex/sessions/* | */.codex/sessions/* | \
		.claude/settings.local.json | */.claude/settings.local.json | \
		.claude/history/* | */.claude/history/* | \
		.claude/projects/* | */.claude/projects/*)
			return 0
			;;
		*) return 1 ;;
	esac
}

in_git=0
if git -C "$root" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
	in_git=1
	git -C "$root" ls-files --cached --others --exclude-standard -z >"$file_list"
	while IFS= read -r -d '' entry; do
		metadata="${entry%%$'\t'*}"
		file="${entry#*$'\t'}"
		mode="${metadata%% *}"
		if is_sensitive_path "$file"; then
			fail "staged sensitive path is not publication-safe: $file"
		fi
		if [ "$mode" = "120000" ]; then
			fail "staged symlink is not publication-safe: $file"
		fi
	done < <(git -C "$root" ls-files --stage -z)
else
	find "$root" -path "$root/.git" -prune -o -type f -print0 >"$file_list"
fi

text_files=()
while IFS= read -r -d '' entry; do
	case "$entry" in
		"$root"/*) file="${entry#"$root"/}" ;;
		*) file="$entry" ;;
	esac

	if is_sensitive_path "$file"; then
		fail "sensitive path is not publication-safe: $file"
	fi
	if [ -L "$root/$file" ]; then
		fail "symlink is not publication-safe: $file"
	fi
	if [ ! -f "$root/$file" ]; then
		continue
	fi

	if LC_ALL=C grep -Iq . "$root/$file"; then
		text_files+=("$file")
	else
		status=$?
		if [ "$status" -ne 1 ]; then
			fail "could not classify text file: $file"
		fi
	fi
done <"$file_list"

is_framework_file() {
	case "$1" in
		README.zh-CN.md | RESEARCH_BRIEF.md | artifacts/* | state/*) return 1 ;;
		*) return 0 ;;
	esac
}

scan_pattern() {
	local label="$1"
	local pattern="$2"
	local scope="$3"
	local skip_verifier="$4"
	local file line status
	local found=0

	for file in "${text_files[@]}"; do
		if [ "$scope" = "framework" ] && ! is_framework_file "$file"; then
			continue
		fi
		if [ "$skip_verifier" = "yes" ] && [ "$file" = "scripts/verify.sh" ]; then
			continue
		fi

		: >"$matches"
		if LC_ALL=C grep -nE -- "$pattern" "$root/$file" >"$matches"; then
			while IFS=: read -r line _; do
				printf '%s:%s: %s\n' "$file" "$line" "$label" >&2
			done <"$matches"
			found=1
		else
			status=$?
			if [ "$status" -ne 1 ]; then
				fail "could not scan $file for $label"
			fi
		fi
	done

	if [ "$in_git" -eq 1 ]; then
		: >"$matches"
		if git -C "$root" grep --cached -I -n -E -e "$pattern" -- >"$matches"; then
			while IFS=: read -r file line _; do
				if [ "$scope" = "framework" ] && ! is_framework_file "$file"; then
					continue
				fi
				if [ "$skip_verifier" = "yes" ] && [ "$file" = "scripts/verify.sh" ]; then
					continue
				fi
				printf '%s:%s: staged %s\n' "$file" "$line" "$label" >&2
				found=1
			done <"$matches"
		else
			status=$?
			if [ "$status" -ne 1 ]; then
				fail "could not scan staged files for $label"
			fi
		fi
	fi

	if [ "$found" -ne 0 ]; then
		return 1
	fi
}

scan_pattern "placeholder text found" 'TBD|TODO|FIXME' framework yes || exit 1
scan_pattern "non-ASCII text found in framework surface" \
	'[^ -~[:space:]]' framework no || exit 1
scan_pattern "machine-specific home path found" \
	"/(home|Users)/[^/[:space:]]+/|/root/|[[:alpha:]]:\\\\Users\\\\" all yes || exit 1
scan_pattern "credential-shaped content found" \
	'-----BEGIN (RSA |EC |OPENSSH )?PRIVATE KEY-----|gh[pousr]_[A-Za-z0-9]{20,}|github_pat_[A-Za-z0-9_]{20,}|sk-[A-Za-z0-9_-]{20,}|AKIA[0-9A-Z]{16}' \
	all yes || exit 1
scan_pattern "email address found" \
	'[[:alnum:]._%+-]+@[[:alnum:].-]+\.[[:alpha:]]{2,}' all yes || exit 1
scan_pattern "private runtime identifier found" \
	'(^|[^[:alnum:]_])([[:alnum:]_-]+__){2}[[:alnum:]_-]+|"(tool_call_id|session_id)"' \
	all yes || exit 1
scan_pattern "prompt or role envelope found" \
	'<(system|developer|user|assistant|tool)>|"role"[[:space:]]*:[[:space:]]*"(system|developer|user|assistant|tool)"|^#{1,6}[[:space:]]+(System|Developer|User|Assistant)[[:space:]]+(Prompt|Message)|^(User|Assistant|System|Developer):[[:space:]]' \
	all yes || exit 1

printf '%s\n' "ResearchLoop Kit structure OK"
