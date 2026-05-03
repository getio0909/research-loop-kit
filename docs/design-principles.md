# Design Principles

This project distills the current repository's domain-heavy research prompt
into a domain-neutral framework.

## 1. Separate Stable Workflow From Variable Domain Input

The original project prompt contains useful research machinery, but it binds the
agent to renewable power forecasting, specific hosts, specific metrics, and
specific file names. ResearchLoop Kit keeps the stable loop in `AGENTS.md` and
moves domain facts into `RESEARCH_BRIEF.md`.

## 2. Use Progressive Disclosure

The base prompt should be short enough to inspect quickly. Detailed formats live
in templates. Long references live in `docs/` or `state/`. The agent loads them
only when the task needs them.

## 3. Make Research Falsifiable

Each iteration must state acceptance criteria, hypotheses, verification methods,
and evidence type. This prevents the agent from producing impressive but
non-actionable summaries.

## 4. Preserve Useful Memory Without Hoarding Context

Persist only decisions, open questions, best results, source indexes, and
iteration summaries. Avoid storing every intermediate thought. State files
should help the next iteration start faster.

## 5. Prefer Small Iterations

Long-running research succeeds by reducing uncertainty one step at a time.
Every iteration should produce at least one durable artifact or decision.

## 6. Keep Skills Lean

The example skill uses a precise trigger, a short workflow, and references to
templates. It does not duplicate all project documentation. A skill should teach
the non-obvious procedure, not become a second README.

## 7. Audit Before Claiming Completion

Completion requires mapping the user's request to real artifacts and verifying
the files or command outputs. A passing script is useful only if the script
covers the requested deliverables.

