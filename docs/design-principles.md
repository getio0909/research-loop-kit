# Design Principles

ResearchLoop Kit favors auditability over autonomy for its own sake. A useful
iteration should change a decision, leave evidence, and be easy to resume.

## Keep The Workflow Stable And The Brief Variable

`AGENTS.md` holds the reusable workflow. `RESEARCH_BRIEF.md` holds the domain,
question, data access, metrics, limits, and deliverables. If a rule changes from
project to project, it belongs in the brief or project state.

## Make One Decision At A Time

An iteration should have one measurable objective and the smallest action that
can change the next decision. Large plans are useful only when each step still
produces a checkpoint or a documented negative result.

## Put Evidence Before Claims

External claims need sources. Data and experiments need provenance, comparable
conditions, and reproducible methods. A polished summary is not a substitute
for raw results or verification.

## Use State As A Checkpoint, Not A Transcript

Keep decisions, open questions, best results, source indexes, and short
iteration summaries. Do not save every intermediate thought or copy chat
history. State should help the next agent start quickly without exposing
private context.

## Treat Goal Mode As Explicit Authorization

Single-iteration execution is the default. Goal mode needs a clear stop
condition, applicable limits, stable IDs, and a checkpoint after every
iteration. Runtime goal features may carry status but never expand permission.

## Keep Published Artifacts Portable

Use repository-relative paths, public reproducibility methods, and redacted
environment descriptions. Apply the artifact-safety and provenance checks
before publishing.

## Keep The Kit Small

Skills should point to shared templates instead of copying them. Checks should
catch real contract drift without becoming a second implementation of the
workflow. When a rule can be stated once and referenced elsewhere, do that.
