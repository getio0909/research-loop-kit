# ResearchLoop Kit

ResearchLoop Kit is a reusable AI research framework for long-running,
evidence-driven research work. It is not tied to one domain. A user supplies a
research brief, and an AI agent follows a compact loop: load state, review
evidence, form hypotheses, run or design experiments, evaluate results, and
persist lessons for the next iteration.

Chinese README: [README.zh-CN.md](README.zh-CN.md)

## Why This Exists

Large research prompts often become brittle because they mix domain facts,
runtime rules, experimental procedure, output formatting, and memory policy in
one huge file. This kit separates those concerns:

- `AGENTS.md` defines the agent behavior.
- `templates/RESEARCH_BRIEF.template.md` captures domain-specific input.
- `templates/*` keeps repeatable artifacts short and scannable.
- `state/` stores long-running memory.
- `skills/run-research-iteration/SKILL.md` shows how to package the loop as a
  reusable skill.

## Quick Start

1. Copy the template:

   ```bash
   cp templates/RESEARCH_BRIEF.template.md RESEARCH_BRIEF.md
   ```

2. Fill in the brief with your domain, research question, data access,
   success metrics, constraints, and deliverables.

3. Run an agent from this directory:

   ```bash
   codex -p "$(cat AGENTS.md)"
   ```

4. Keep each iteration's output in `state/` and `artifacts/`.

5. Run the structure check before publishing:

   ```bash
   bash scripts/verify.sh
   ```

## Core Loop

Each iteration follows nine steps:

1. Load the research brief and prior state.
2. Restate the objective as measurable success criteria.
3. Review current evidence and cite sources.
4. Propose one to three testable hypotheses.
5. Choose a small experiment, analysis, or synthesis task.
6. Execute only within the user's constraints.
7. Evaluate against the success metrics.
8. Persist decisions, open questions, and reusable lessons.
9. Produce the next concrete iteration plan.

## Design Principles

- Keep the base prompt domain-neutral.
- Put domain facts in the brief, not in the agent prompt.
- Use progressive disclosure: keep `AGENTS.md` short and move detailed formats
  into templates.
- Prefer evidence and acceptance gates over motivational wording.
- Separate "research memory" from "research outputs".
- Make every claim traceable to data, source material, experiment output, or
  an explicitly marked assumption.

## Directory Layout

```text
research-loop-kit/
|-- AGENTS.md
|-- README.md
|-- README.zh-CN.md
|-- docs/
|   |-- design-principles.md
|   `-- reference-notes.md
|-- templates/
|   |-- RESEARCH_BRIEF.template.md
|   |-- ITERATION_REPORT.template.md
|   |-- EVIDENCE_NOTE.template.md
|   `-- EXPERIMENT_CARD.template.md
|-- skills/
|   `-- run-research-iteration/
|       `-- SKILL.md
|-- examples/
|   `-- RESEARCH_BRIEF.example.md
|-- state/
|   `-- .gitkeep
|-- artifacts/
|   `-- .gitkeep
`-- scripts/
    `-- verify.sh
```

## What To Customize

Edit only these files for most projects:

- `RESEARCH_BRIEF.md`: the current research problem and constraints.
- `state/research_log.md`: iteration history.
- `state/leaderboard.md`: best results or strongest findings.
- `state/open_questions.md`: unresolved questions.

Avoid editing `AGENTS.md` for every domain. If the prompt needs frequent
domain-specific edits, move those details into the research brief or a separate
reference file.

## Publishing Notes

This project is intentionally small. It should be easy to audit, fork, and
adapt. The reference notes cite public examples that influenced the structure,
but this kit does not copy large prompt bodies from other projects.
