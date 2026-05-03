# Research Brief

## 1. Research Identity

- Project name: Low-cost indoor air quality sensing review
- Domain: Environmental sensing
- Research owner: Example user
- Current date basis: Use the current system date
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

- Data sources: Public datasheets and peer-reviewed comparison studies.
- Literature sources: Papers, manufacturer docs, and reproducible benchmarks.
- Existing notes: None.
- Existing code or tools: None.
- Baselines to compare against: Reference-grade particle counters where papers
  provide comparisons.

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
- Who will use the results: Prototype builder.

## 8. Open Questions

- Unknowns that must be resolved: Which sensors are currently available.
- Assumptions allowed for the first iteration: North America availability.
- Decisions deferred until later: Final enclosure and firmware design.

