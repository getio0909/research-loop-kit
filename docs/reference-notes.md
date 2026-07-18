# Design References

These public sources led to concrete choices in ResearchLoop Kit.

| Source | Choice adopted here |
|---|---|
| [OpenAI prompt engineering guide](https://developers.openai.com/api/docs/guides/prompt-engineering) | Explicit instructions, structured outputs, and verification. |
| [OpenAI Codex agent guidance](https://developers.openai.com/codex/guides/agents-sdk) | Scoped handoffs and reviewable artifacts for longer work. |
| [Anthropic skill development guide](https://github.com/anthropics/claude-code/blob/main/plugins/plugin-dev/skills/skill-development/SKILL.md) | Lean skill files and progressive disclosure. |
| [Superpowers writing-skills](https://github.com/obra/superpowers/blob/main/skills/writing-skills/SKILL.md) | Trigger-focused skill descriptions and shared references. |
| [karpathy/autoresearch](https://github.com/karpathy/autoresearch) | Baseline-first optimization, comparable budgets, and retained failed runs. |
| [getcompanion-ai/feynman](https://github.com/getcompanion-ai/feynman) | Slugged artifacts, source checks, provenance, and explicit blocked states. |
| [bytedance/deer-flow](https://github.com/bytedance/deer-flow) | Filesystem checkpoints, progressive context loading, and execution boundaries. |

The kit keeps these decisions:

- one iteration by default, with explicit authorization for goal mode;
- a baseline before an optimization claim;
- a durable checkpoint after every goal-mode iteration;
- clear separation between source reports, observations, computed results, and
  assumptions;
- provenance and useful negative results;
- smoke-test-only treatment of synthetic data unless the brief permits it as
  evidence.

Prefer official documentation, primary sources, public repositories, and files
that another maintainer can inspect. Do not use leaked or proprietary prompt
collections. Repository statistics and search snippets can help discovery, but
they are not design authority.
