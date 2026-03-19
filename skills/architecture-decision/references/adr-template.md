# ADR Template

Standard Architecture Decision Record template for Baufest engagements.

## ADR-[NUMBER]: [Decision Title]

**Status**: Proposed | Accepted | Deprecated | Superseded by ADR-[N]
**Date**: YYYY-MM-DD
**Decision Makers**: [Names and roles]
**Consulted**: [Names and roles of those consulted]
**Informed**: [Names and roles of those who need to know]

---

### Context

Describe the situation that requires a decision. Include:

- **Background**: What is the system/project/initiative this decision affects?
- **Problem statement**: What specific problem or need drives this decision?
- **Current state**: What exists today? What's working, what's not?
- **Constraints**: Technical, organizational, financial, timeline, or regulatory constraints that bound the decision space.

**Guidance**: Write enough context that someone unfamiliar with the project can understand why this decision matters. Be factual, not persuasive.

---

### Decision Drivers

Ordered list of criteria used to evaluate options. These are the factors that matter most for this specific decision.

1. **[Driver name]**: [Description and why it matters]
2. **[Driver name]**: [Description and why it matters]
3. **[Driver name]**: [Description and why it matters]

**Guidance**: Limit to 4–7 drivers. Rank them by importance. These drivers should be agreed upon by stakeholders before evaluating options — they prevent post-hoc rationalization.

---

### Options Considered

#### Option 1: [Name]

**Description**: [What this option entails — 2–3 sentences]

| Criterion | Assessment |
|-----------|-----------|
| [Driver 1] | [How this option performs against this driver] |
| [Driver 2] | [How this option performs against this driver] |
| [Driver 3] | [How this option performs against this driver] |

**Pros**:
- [Advantage 1]
- [Advantage 2]

**Cons**:
- [Disadvantage 1]
- [Disadvantage 2]

**Risks**:
- [Risk 1 — likelihood and impact]

**Estimated Effort/Cost**: [Quantify where possible]

---

#### Option 2: [Name]

[Same structure as Option 1]

---

#### Option 3: [Name] (if applicable)

[Same structure as Option 1]

---

### Decision Outcome

**Chosen Option**: [Option name]

**Rationale**: [2–3 sentences explaining why this option best satisfies the decision drivers. Reference specific drivers by name.]

**Tradeoffs Accepted**:
- [Downside 1 — why it's tolerable]
- [Downside 2 — why it's tolerable]

**Reversibility**: [One-way door / Easily reversible / Partially reversible. Explain.]

**Conditions for Revisiting**:
- [Circumstance that would trigger reconsideration]
- [Metric threshold that would indicate the decision should be revisited]

---

### Consequences

**Positive**:
- [What becomes easier or better]
- [What new capabilities are enabled]

**Negative**:
- [What becomes harder or more complex]
- [What new constraints are introduced]

**Follow-up Actions**:
1. [Action] — [Owner] — [Target date]
2. [Action] — [Owner] — [Target date]

---

### Compliance Notes (if applicable)

- **Security**: [Impact on security posture]
- **Data privacy**: [GDPR, CCPA, or other regulatory considerations]
- **Audit**: [Logging, traceability, or audit trail implications]
- **Licensing**: [Open source or commercial license considerations]

---

### References

- [Link to relevant documentation, benchmarks, or prior ADRs]
