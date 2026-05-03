---
name: run-research-iteration
description: Use when a user wants an AI agent to run or design one evidence-driven research iteration in any domain, especially when there is a research brief, prior state, experiments, literature, or a need to persist findings.
---

# Run Research Iteration

Run one compact, falsifiable research iteration. Use the user's current brief,
state files, and available evidence. Do not assume domain facts.

## Trigger Check

Use this skill when the task includes:

- a research question or literature review,
- an experiment or benchmark,
- a need to improve a result over iterations,
- a request to update research memory,
- a generic research framework or prompt-driven research workflow.

Do not use this skill for one-off factual answers that need no persistent state.

## Workflow

1. Load `RESEARCH_BRIEF.md`.
2. Load relevant files under `state/`.
3. Restate the objective as measurable acceptance criteria.
4. Review the smallest useful set of evidence.
5. Mark claims as `source-backed`, `data-backed`, `experiment-backed`, or
   `assumption`.
6. Propose one to three hypotheses.
7. Select the smallest action that can change the next decision.
8. Execute or design the action within the brief's constraints.
9. Evaluate against the brief's metrics and prior best result.
10. Update state and save artifacts.
11. End with the next concrete iteration target.

## Templates

- Use `templates/RESEARCH_BRIEF.template.md` when the brief is missing.
- Use `templates/ITERATION_REPORT.template.md` for the final report.
- Use `templates/EVIDENCE_NOTE.template.md` for source review.
- Use `templates/EXPERIMENT_CARD.template.md` for experiments or benchmarks.

## Quality Gates

- No uncited external claims.
- No invented domain facts.
- No destructive actions unless allowed by the brief.
- No completion claim until artifacts and state updates are verified.
- Negative results must be recorded if they change future decisions.

## Output

Return a short iteration report with:

- objective,
- evidence reviewed,
- hypotheses and result,
- best current answer or method,
- artifacts,
- state updates,
- next iteration.

