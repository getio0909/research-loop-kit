# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.0] - 2026-06-02

### Added

- `.gitignore` for common unwanted files.
- `.github/workflows/verify.yml` for automated structure checks on push and PR.
- `skills/init-research-project/SKILL.md` for project initialization.
- `CONTRIBUTING.md` with contribution guidelines.
- `CHANGELOG.md` for version tracking.
- Version field to `RESEARCH_BRIEF.template.md`.

### Changed

- `scripts/verify.sh`: replaced predictable temp file path with `mktemp` to prevent symlink attacks.
- `scripts/verify.sh`: added `trap` for reliable cleanup on exit.
- `skills/run-research-iteration/SKILL.md`: shortened description for better compatibility with agent tooling.
- `README.md` and `README.zh-CN.md`: updated Quick Start to cover multiple agent platforms.

## [0.1.0] - 2026-05-03

### Added

- Initial release with core research loop, templates, state management, and verify script.
