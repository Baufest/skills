---
name: architecture-decision
description: >-
  Produce structured Architecture Decision Records (ADRs) with options analysis,
  tradeoffs, and a clear recommendation. Use this skill when making technology
  choices, evaluating build-vs-buy, selecting platforms or frameworks, choosing
  between architectural patterns, or documenting any significant technical
  decision. Also triggers for: "decision doc", "options analysis", "tech
  evaluation", "design decision", "technology comparison", "should we use X
  or Y", "what database should we pick", or "evaluate these options". Covers
  context, decision drivers, options with pros/cons/risks, decision outcome,
  and consequences. Do NOT use for project plans, delivery status reports,
  proposals, or general technical documentation.
license: Apache-2.0
metadata:
  author: baufest
  version: "1.0"
---

# Architecture Decision Record

## Overview

Produce rigorous Architecture Decision Records (ADRs) that capture the context, options, tradeoffs, and rationale behind significant technical decisions. ADRs are durable artifacts — they explain *why* a decision was made so that future teams don't relitigate settled questions.

## When to Use

- Choosing a technology, framework, or platform
- Evaluating build vs buy
- Selecting an architectural pattern (monolith vs microservices, event-driven vs request-response, etc.)
- Making infrastructure decisions (cloud provider, database, messaging system)
- Any technical decision that affects multiple teams, is expensive to reverse, or will be questioned later

## Instructions

### Step 1: Define the Decision

Ask the user for (skip what's already provided):

1. **What decision needs to be made?** — One clear sentence.
2. **Why does this decision matter?** — Business or technical impact.
3. **What are the constraints?** — Timeline, budget, team skills, compliance, existing systems.
4. **Who are the stakeholders?** — Who needs to approve or be informed?
5. **What options are being considered?** — At least 2, ideally 3–4.

### Step 2: Structure the ADR

Follow the template in [references/adr-template.md](references/adr-template.md). Every section is required.

Apply these principles:

- **Balanced analysis**: Present every option fairly before recommending. Show genuine pros AND cons for each — including the recommended option.
- **Decision drivers first**: List the criteria that matter most before evaluating options. This prevents post-hoc rationalization.
- **Quantify tradeoffs**: Cost in dollars, latency in milliseconds, migration effort in weeks. Avoid "better" / "worse" without metrics.
- **Acknowledge uncertainty**: If an option has unknowns, say so. "Vendor X's pricing at scale is unclear — we estimate $Y based on similar workloads" is better than a false-precision number.
- **Reversibility**: Explicitly state whether the decision is easily reversible or a one-way door.

### Step 3: Make the Recommendation

The ADR must include a clear recommendation with rationale. Structure as:

1. **Decision**: State the chosen option in one sentence.
2. **Rationale**: Why this option best satisfies the decision drivers.
3. **Tradeoffs accepted**: What downsides are being accepted and why they're tolerable.
4. **Conditions for revisiting**: Under what circumstances should this decision be reconsidered?

### Step 4: Document Consequences

List both positive and negative consequences of the decision:

- **What becomes easier** as a result of this decision
- **What becomes harder** as a result of this decision
- **Follow-up actions** required to implement the decision
- **Compliance notes** if the decision has regulatory or security implications

### Step 5: Format and Deliver

Output as a structured Markdown document following the ADR template. Use precise, technical language. The ADR should be understandable by a senior engineer joining the project 6 months from now.

## Output Format

A single Markdown document following the ADR template. Typical length: 2–5 pages. Each option gets a structured analysis. The recommendation is unambiguous. The document is self-contained — a reader needs no additional context.

## References

- See [adr-template.md](references/adr-template.md) for the complete ADR template with field guidance
