# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Goal mode for explicitly authorized multi-iteration work, with limits and
  resumable checkpoints.
- Goal state tracking for authorization, limits, stable IDs, status, and safe
  retries of external actions.
- Checks for likely secrets and local or runtime-specific metadata without
  printing matched content.

### Changed

- Replaced the ten-step loop with a simpler eight-phase workflow.
- Made initialization idempotent and tightened repository checks.
- Simplified design documentation and removed project-specific source history.
- Documented that agent-specific skill packages are outside the public
  repository distribution.
- Hardened CI with pinned actions, read-only permissions, ShellCheck, and a
  timeout.

### Fixed

- Corrected current Codex and Claude Code launch instructions.
- Prevented Quick Start from overwriting an existing research brief.
- Aligned the agent instructions, READMEs, and templates.

## [0.2.0] - 2026-06-02

### Added

- `.gitignore` for common unwanted files.
- `.github/workflows/verify.yml` for automated structure checks on push and PR.
- `CONTRIBUTING.md` with contribution guidelines.
- `CHANGELOG.md` for version tracking.
- Version field to `RESEARCH_BRIEF.template.md`.

### Changed

- `scripts/verify.sh`: replaced predictable temp file path with `mktemp` to prevent symlink attacks.
- `scripts/verify.sh`: added `trap` for reliable cleanup on exit.
- `README.md` and `README.zh-CN.md`: updated Quick Start to cover multiple agent platforms.

## [0.1.0] - 2026-05-03

### Added

- Initial release with core research loop, templates, state management, and verify script.
