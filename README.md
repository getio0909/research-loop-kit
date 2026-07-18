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
- `artifacts/` stores reports, plans, result logs, and provenance sidecars.
- `skills/run-research-iteration/SKILL.md` shows how to package the loop as a
  reusable skill.

The bundled skill sources are kept under `skills/` for portability. Install or
link them from the skill directory supported by your agent if you want automatic
discovery. They expect a full ResearchLoop Kit checkout, locate templates from
the project root, and do not embed separate prompt or template copies.

## Quick Start

1. Copy the template without overwriting an existing brief:

   ```bash
   if [ -L RESEARCH_BRIEF.md ]; then
     echo "RESEARCH_BRIEF.md is a symlink; refusing to continue."
     exit 1
   elif [ ! -e RESEARCH_BRIEF.md ]; then
     cp templates/RESEARCH_BRIEF.template.md RESEARCH_BRIEF.md
   elif [ -f RESEARCH_BRIEF.md ]; then
     echo "RESEARCH_BRIEF.md already exists; leaving it unchanged."
   else
     echo "RESEARCH_BRIEF.md is not a regular file; refusing to continue."
     exit 1
   fi
   ```

2. Fill in the brief with your domain, research question, data access,
   success metrics, constraints, and deliverables.

3. Start an agent from the repository root. Use its supported project-instruction
   mechanism to load `AGENTS.md`:

   **OpenAI Codex:**

   ```bash
   codex
   ```

   Codex discovers the repository's `AGENTS.md` automatically.

   **Claude Code:**

   ```bash
   claude --append-system-prompt-file AGENTS.md
   ```

   **Any agent:** Load `AGENTS.md` as the system prompt or instructions file
   for your preferred AI tool.

4. Keep each iteration's output in `state/` and `artifacts/`.

5. Run the structure check before publishing:

   ```bash
   bash scripts/verify.sh
   ```

   This checks the framework's structure and publication safety. The
   initialization and iteration skills enforce project-specific readiness.

## Core Loop

Each iteration follows eight phases:

<!-- research-loop-phases:start -->

1. Confirm the authorized execution mode and load the brief and prior state.
2. Lock one measurable objective and its acceptance criteria.
3. Review the smallest useful evidence set and label claim support.
4. Frame testable hypotheses, decision alternatives, or the uncertainty to reduce.
5. Choose the smallest action that can change the next decision.
6. Execute within the brief's permissions and limits.
7. Evaluate against the criteria and any applicable baseline or prior best.
8. Save and verify the checkpoint, then set the next action or terminal status.

<!-- research-loop-phases:end -->

## Goal Mode

ResearchLoop Kit is provider-neutral and works with or without a persistent
goal feature:

- Single-iteration mode is the default and returns control after one loop.
- Goal mode requires explicit user authorization, measurable acceptance
  criteria, a stop condition, a maximum iteration count, and any other
  applicable limits.
- Every goal-mode iteration still passes the same persistence and completion
  gates before another iteration begins.
- A goal-capable runtime may mirror the public objective and status, but it does
  not gain broader scope, permissions, or budget.
- Map provider-specific statuses to the six canonical goal states before
  comparing them; an unknown status pauses work for confirmation.
- Before continuing, reconcile the runtime status with `state/goal.md`; a
  withdrawn authorization or non-active status in either place takes
  precedence over a stale `active` value.
- The goal state must match the current series ID and brief version; a material
  brief change or due authorization review pauses work until renewed approval.
- A goal checkpoint has one writer unless the surrounding system supplies
  locking or compare-and-swap and reserves external action IDs atomically.
- Runtimes without goal support use `state/goal.md`, created from
  `templates/GOAL_STATE.template.md`, as the resumable checkpoint.
- Meeting the acceptance criteria with evidence is the only successful
  completion. A fired stop condition or exhausted limit produces `stopped`.
- Use `paused` for a temporary user pause, `blocked` for a missing external
  dependency, and `cancelled` when authorization is withdrawn.
- Persist non-repeatable external actions as `planned` with an action ID before
  execution, then record the receipt; reconcile uncertain results before retry.

## Research Integrity

- Final or reusable outputs should include provenance: sources accepted or
  rejected, data versions, commands, raw artifact paths, and verification state.
- Synthetic, simulated, mock, random, or example data can be used for smoke
  tests only unless the brief explicitly allows it as evidence.
- Optimization work should start from a baseline and compare results under a
  fixed budget or otherwise comparable conditions.
- Substantial or resumable work should externalize plans and working notes under
  `artifacts/` instead of relying on chat history.
- Apply the artifact-safety rules in `AGENTS.md` and the publication checklist
  in `templates/PROVENANCE.template.md` before saving reusable output.

Design decisions and their trade-offs are documented in
[`docs/design-principles.md`](docs/design-principles.md).
Public sources that influenced those decisions are listed in
[`docs/reference-notes.md`](docs/reference-notes.md).

## Directory Layout

```text
research-loop-kit/
|-- AGENTS.md
|-- CHANGELOG.md
|-- CONTRIBUTING.md
|-- README.md
|-- README.zh-CN.md
|-- docs/
|   |-- design-principles.md
|   `-- reference-notes.md
|-- templates/
|   |-- RESEARCH_BRIEF.template.md
|   |-- GOAL_STATE.template.md
|   |-- ITERATION_REPORT.template.md
|   |-- EVIDENCE_NOTE.template.md
|   |-- EXPERIMENT_CARD.template.md
|   `-- PROVENANCE.template.md
|-- skills/
|   |-- run-research-iteration/
|   |   `-- SKILL.md
|   `-- init-research-project/
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
- `state/decision_log.md`: durable decisions and their evidence.
- `state/source_index.md`: reusable sources and data provenance.
- `state/goal.md`: goal-mode status and checkpoints, when explicitly enabled.

Avoid editing `AGENTS.md` for every domain. If the instructions need frequent
domain-specific edits, move those details into the research brief or a separate
reference file.
