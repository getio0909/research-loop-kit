# Research Brief

## 1. Research Identity

- Brief version: 1
- Project name: Low-cost indoor air quality sensing review
- Research series ID: indoor-air-sensor-review
- Domain: Environmental sensing
- Current date basis: Use the current system date
- Execution mode: Single iteration
- Expected iteration length: 1 to 2 hours

## 2. Research Question

- Primary question: Which low-cost sensor families are most reliable for indoor
  PM2.5 monitoring under typical home conditions?
- Secondary questions:
  - What calibration methods are commonly used?
  - Which failure modes matter most for long-term deployment?
- Why this matters: The result will guide prototype hardware selection.
- What is out of scope: Outdoor pollution modeling and regulatory compliance
  certification.

## 3. Success Criteria

- Primary metric or decision criterion: A ranked shortlist with evidence for
  accuracy, cost, calibration burden, and availability.
- Secondary metrics: Maintenance effort and documented drift behavior.
- Minimum acceptable outcome: Three candidate sensor families with cited
  evidence and known caveats.
- What counts as failure: Recommendations without sources or without discussing
  calibration.
- Stop condition: A sensor family is selected for prototype testing.

## 4. Inputs

- Available local inputs: None.
- Permitted external sources: Public manufacturer pages, public datasheets,
  peer-reviewed papers, and reproducible public benchmarks.
- Access method: Web research and downloaded public documents only.
- Existing notes or code: None.
- Baselines to compare against: Reference-grade particle counters where papers
  provide comparisons.
- Synthetic, simulated, mock, or example data policy: Not allowed for sensor
  reliability conclusions; allowed only for formatting smoke tests.

## 5. Constraints

- Allowed actions: Web research, source notes, comparison table.
- Forbidden actions: Purchases, contacting vendors, scraping behind logins.
- Compute limits: None.
- Budget limits: Prefer sensors under USD 50 per unit.
- Time limits: One iteration should produce a shortlist.
- Privacy, safety, or compliance limits: None.

## 6. Method Preferences

- Preferred methods: Source-backed comparison and uncertainty notes.
- Methods to avoid: Single-source recommendations.
- Required validation: At least two independent source types for the final
  shortlist where possible.
- Required output formats: Markdown report and source index.

## 7. Deliverables

- Main deliverable: Ranked shortlist.
- Supporting artifacts: Evidence notes and comparison table.
- Where artifacts should be saved: `artifacts/`
- Intended audience or role: Prototype builder.

## 8. Open Questions

- Unknowns that must be resolved: Which sensors are currently available.
- Assumptions allowed for the first iteration: North America availability.
- Decisions deferred until later: Final enclosure and firmware design.

## 9. Goal Mode (Optional)

Not used in this single-iteration example.
