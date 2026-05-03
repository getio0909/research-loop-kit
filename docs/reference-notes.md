# Reference Notes

These sources influenced the structure of ResearchLoop Kit. They were used for
patterns and constraints, not copied as full prompt bodies.

## OpenAI Official Sources

- OpenAI prompt engineering guide:
  https://developers.openai.com/api/docs/guides/prompt-engineering
  - Useful pattern: role clarity, structured tool use, testing, Markdown
    standards, and long-running agent prompts that emphasize planning,
    persistence, preambles, and task tracking.

- OpenAI Codex multi-agent workflows:
  https://developers.openai.com/codex/guides/agents-sdk
  - Useful pattern: deterministic, reviewable workflows with scoped agents,
    handoffs, guardrails, and traceable artifacts.

- OpenAI Agents SDK session memory cookbook:
  https://developers.openai.com/cookbook/examples/agents_sdk/session_memory
  - Useful pattern: summarize old context, keep recent turns intact, preserve
    milestones, contradictions, timestamps, tool insights, and hallucination
    controls.

## Public GitHub And Skill Sources

- Discovery snapshot on 2026-05-03:
  - `anthropics/claude-code`: 120074 GitHub stars.
  - `obra/superpowers`: 177154 GitHub stars.
  - `PatrickJS/awesome-cursorrules`: 39362 GitHub stars.
  - `secondsky/claude-skills`: 132 GitHub stars, 170 skills described in
    repository metadata and README search snippets.
  - `simota/agent-skills`: 31 GitHub stars, 100+ cross-agent skills described
    in repository metadata and README search snippets.

- Anthropic Claude Code skill development guide:
  https://github.com/anthropics/claude-code/blob/main/plugins/plugin-dev/skills/skill-development/SKILL.md
  - Useful pattern: `SKILL.md` frontmatter, optional `scripts/`,
    `references/`, `assets/`, and progressive disclosure.

- Superpowers writing-skills:
  https://github.com/obra/superpowers/blob/main/skills/writing-skills/SKILL.md
  - Useful pattern: skill descriptions should describe trigger conditions, not
    summarize the workflow; heavy references should move out of the main skill.

- Awesome Cursor Rules:
  https://github.com/PatrickJS/awesome-cursorrules
  - Useful pattern: project-specific AI rules can align teams, encode local
    conventions, and improve context awareness.

- secondsky/claude-skills:
  https://github.com/secondsky/claude-skills
  - Useful pattern: many small, focused skills are easier to scan and reuse
    than one monolithic prompt.

- simota/agent-skills:
  https://github.com/simota/agent-skills
  - Useful pattern: cross-agent skills can cover development, security,
    design, compliance, and research-like workflows when written portably.

## Source Selection Notes

- Preference went to official docs, public GitHub repositories, and
  independently inspectable markdown files.
- Leaked or proprietary system prompt collections were not used as source
  material.
- Star counts and repository descriptions can change; treat them as discovery
  signals, not design authority.
