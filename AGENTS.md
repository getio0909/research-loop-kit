# ResearchLoop Kit Agent Instructions

## Purpose

Turn a research brief into small, evidence-backed advances that another agent
can inspect and continue. Keep the workflow domain-neutral. Domain facts,
metrics, data access, limits, and deliverables belong in `RESEARCH_BRIEF.md`,
not here.

These instructions apply when using the kit for research. If the user asks to
maintain the kit itself, inspect and change the repository normally; a research
brief and research state are not required for framework maintenance.

## Choose An Execution Mode

- **Single iteration** is the default. Complete one iteration, save the result,
  and return control to the user.
- **Goal mode** is for explicitly authorized multi-iteration work. It requires
  measurable acceptance criteria, a stop condition, and any applicable time,
  cost, compute, or iteration limits.

A runtime's persistent-goal feature may carry the public objective and status,
but it does not add permissions, budget, or scope. Without such a feature,
`state/goal.md` is the checkpoint for a later invocation.

## Start With The Brief And State

Read these files when they exist:

1. `RESEARCH_BRIEF.md`
2. `state/goal.md` in goal mode
3. `state/research_log.md`
4. `state/leaderboard.md`
5. `state/open_questions.md`
6. `state/decision_log.md`
7. `state/source_index.md`

If `RESEARCH_BRIEF.md` is missing and the user asks to initialize the project,
copy `templates/RESEARCH_BRIEF.template.md` without overwriting existing work,
then list the required fields that are still blank. Do not invent the problem.
Use `skills/init-research-project/SKILL.md` for the full initialization flow.

For any other research request, a missing or incomplete brief is a blocker. At
minimum it must define a brief version, research-series ID, execution mode,
primary question, primary decision criterion, minimum acceptable outcome, stop
condition, permitted data, allowed and forbidden actions, data policy, and main
deliverable. Goal mode also requires a maximum iteration count, authorization
review or expiry condition, and checkpoint cadence.

## Working Files

- `RESEARCH_BRIEF.md`: question, scope, success criteria, and constraints.
- `state/research_log.md`: dated iteration summaries.
- `state/decision_log.md`: decisions that should survive future turns.
- `state/leaderboard.md`: comparable best results or strongest findings.
- `state/open_questions.md`: unresolved questions and blockers.
- `state/source_index.md`: reusable sources and data provenance.
- `state/goal.md`: authorization, limits, checkpoints, status, and next action.
- `artifacts/`: reports, evidence notes, experiment records, scripts, and logs.

Create state files only when needed. Append history instead of rewriting it.

## Run One Research Iteration

<!-- research-loop-phases:start -->

1. **Confirm authorization and load**: confirm the execution mode, scope,
   constraints, available tools, prior results, and unresolved questions.
2. **Lock the objective**: state the decision this iteration should change and
   the measurable acceptance criteria.
3. **Review evidence**: inspect the smallest useful source, dataset, note, or
   prior experiment set. Mark key claims as `source-backed`, `data-backed`,
   `experiment-backed`, or `assumption`.
4. **Frame what to test**: propose one to three hypotheses or decision
   alternatives, each with a verification method. If neither fits, state the
   uncertainty this iteration will reduce.
5. **Choose an action**: select the smallest analysis, experiment, source
   review, or synthesis that can change the next decision.
6. **Execute**: carry out that action within the brief's permissions and limits.
7. **Evaluate**: compare the result with the acceptance criteria and any
   applicable baseline or prior best result. Keep useful negative results.
8. **Checkpoint and transition**: save the result and provenance, run relevant
   checks, update state, and set the next action or terminal status.

<!-- research-loop-phases:end -->

Each non-blocked iteration must leave a durable result: a state update, report,
evidence note, experiment record, reproducible artifact, comparable result, or
narrowed open question. If work is blocked, record the missing input or
permission and the smallest action that would unblock it. Do not improvise data
or results.

## Goal Mode

Create `state/goal.md` from `templates/GOAL_STATE.template.md` before starting.
Use a stable research-series ID and iteration ID. Before executing an iteration,
check whether that ID is already complete; resume an incomplete checkpoint or
skip completed work rather than duplicating artifacts or log entries.

After every iteration, update evidence, limits used, status, and next action.
Use one of these statuses: `active`, `paused`, `blocked`, `completed`,
`stopped`, or `cancelled`.

Normalize provider-specific runtime statuses to those six values before
reconciliation. A documented running or in-progress state maps to `active`;
unknown or ambiguous values pause continuation for confirmation. Keep the
provider-native value only in the runtime-observation field.

Before continuing, reconcile any runtime goal status with `state/goal.md`. A
withdrawn authorization or a non-active status in either place stops automatic
continuation. Never let a stale `active` value overwrite `paused`, `blocked`,
`completed`, `stopped`, `cancelled`, or withdrawn authorization. The user's
current authorization and the brief define scope; the state file is the audit
record.

The goal state's research-series ID and brief version must match the current
brief. If the brief changed materially or the authorization review or expiry
condition is due, pause and obtain renewed authorization before continuing.

Treat a goal checkpoint as single-writer state. Do not run two iterations for
the same research series concurrently unless the state store provides locking
or compare-and-swap and external action IDs can be reserved atomically.

For any action that can spend money, contact people, mutate external state, or
cannot be safely repeated, record an action ID and idempotency key when the
system supports one. Persist the action intent as `planned` before execution,
then record its receipt and status afterward. If a run fails after the action
but before checkpointing, inspect the external state or receipt before retrying.
Never replay an uncertain non-idempotent action only because the local
checkpoint is missing.

Continue only when all of the following are true:

- the goal is still authorized and active;
- the series ID and brief version match the current brief;
- authorization review or expiry is not due;
- acceptance criteria are not yet met;
- applicable limits still allow work;
- the configured stop condition has not fired;
- no external input or permission is missing;
- a concrete next action exists.

`completed` requires verified acceptance evidence. Use `stopped` when a limit
or stop condition ends the run without meeting acceptance criteria, `paused`
for a temporary user-requested pause, `blocked` for a named external
dependency, and `cancelled` when the user withdraws authorization.

## Evidence And Artifact Safety

- Cite external claims and prefer primary sources, official documentation,
  direct data, and reproducible outputs.
- For dataset-backed results, record a public URL or repository-relative path,
  acquisition method, version or snapshot, filters or splits, and producing
  command or artifact.
- For experiment-backed results, record the public command or method,
  configuration, comparable conditions, metrics, and artifact path.
- Synthetic, simulated, random, mock, or example data may support conclusions
  only when the brief explicitly permits it. Otherwise label it `SMOKE TEST
  ONLY` and exclude it from best-result claims.
- Never turn missing data, failed checks, or unavailable tools into invented
  metrics, tables, plots, sources, or conclusions.
- Do not train, scrape, spend money, contact people, access sensitive data, or
  perform destructive actions unless both the brief and user authorization
  allow it.
- Persist only task-relevant facts and concise summaries. Never store private
  prompts, raw conversations, credentials, personal or customer data, internal
  orchestration identifiers, runtime identity, or unrelated machine metadata.
- Use repository-relative paths and public reproducibility methods. Redact user
  names, host names, private endpoints, environment values, tokens, headers,
  cookies, and machine-specific absolute paths before publishing.

## Review And Completion

Run a brief health review at the cadence in the brief, after a material brief
change, when comparable attempts repeatedly fail to make progress, when
blockers accumulate, or when the user asks. Recheck stale assumptions,
decisions, open questions, and the best result; end with one recommended next
action.

Before claiming an iteration or goal complete:

- verify referenced files and artifact paths;
- run the relevant checks and record their results;
- mark checks that could not run and explain why;
- downgrade or remove unsupported claims;
- update the state and goal checkpoint;
- complete the artifact-safety review before publishing.

End with:

```text
Iteration: <series and iteration ID or date>
Research question: <one sentence>
Acceptance criteria: <criteria>
Evidence reviewed: <sources, data, or experiments>
Tests or alternatives: <hypothesis, alternative, or uncertainty -> result>
Result: <what changed>
Best current answer or method: <current best>
Verification: <checks and result>
Risks and gaps: <remaining uncertainty>
Artifacts: <repository-relative paths>
State updates: <files changed>
Goal status: <status or not applicable>
Next iteration: <specific action, or none for a terminal status>
```

Write plainly. Prefer concrete evidence and short decision records over process
commentary or motivational language.
