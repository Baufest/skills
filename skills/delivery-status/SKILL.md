---
name: delivery-status
description: >-
  Write delivery status reports — weekly updates, steering committee summaries,
  and executive roll-ups. Use this skill when creating a status report, weekly
  update, delivery update, progress report, steering committee summary, or
  executive project summary. Also triggers for: "write up the status", "what's
  the update", "prepare the weekly report", "steering committee deck", "project
  health summary", or "roll up the status across workstreams". Produces
  forward-looking reports that emphasize next actions over retrospective
  narrative. Do NOT use for proposals (use proposal-builder), engagement briefs
  (use client-engagement-brief), or architecture documentation.
license: Apache-2.0
metadata:
  author: baufest
  version: "1.0"
---

# Delivery Status Reports

## Overview

Generate structured delivery status reports that drive decisions and surface risks early. Status reports are the primary communication channel between delivery teams and stakeholders. They must be forward-looking — what's next matters more than what happened.

## When to Use

- Weekly project status updates
- Steering committee or governance meeting summaries
- Executive roll-ups across multiple workstreams
- Sprint reviews or iteration summaries
- Escalation reports when issues need attention
- Any recurring delivery communication

## Instructions

### Step 1: Identify the Report Type

Determine which format to use based on the audience and context:

| Type | Audience | Cadence | Format |
|------|----------|---------|--------|
| Weekly Update | Delivery team + client PM | Weekly | Detailed, operational |
| Steering Committee | Client leadership + Baufest leadership | Bi-weekly/Monthly | Strategic, summary-level |
| Executive Roll-up | C-suite / Portfolio level | Monthly/Quarterly | High-level, multi-project |

Load the appropriate example for format guidance:
- For weekly updates, see [examples/weekly-update.md](examples/weekly-update.md)
- For steering committee summaries, see [examples/steering-committee.md](examples/steering-committee.md)
- For executive roll-ups, adapt the steering committee format with a multi-project view

### Step 2: Gather Status Information

Ask the user for (skip what's already provided):

1. **Project/engagement name and reporting period**
2. **Overall health** — Green / Amber / Red with brief justification
3. **Key accomplishments** this period (keep to 3–5 items)
4. **Upcoming milestones** — what's next and when
5. **Risks and blockers** — anything threatening delivery
6. **Decisions needed** — what needs to be resolved and by whom
7. **Metrics** — velocity, burn rate, quality metrics, or other KPIs if available

### Step 3: Draft the Report

Apply these principles:

- **Forward-looking framing**: Lead with what's ahead. "Next week, the team will..." comes before "This week, the team completed...". Past accomplishments provide context; future actions drive value.
- **RAG status with teeth**: Red/Amber/Green must have specific, measurable criteria. Define what "Green" means for this project. Don't default to Green to avoid difficult conversations.
- **Risks are opportunities to lead**: Surface risks early with clear mitigations. "Risk: API vendor has not confirmed SLA → Mitigation: Fallback architecture designed, decision needed by March 15."
- **Decisions, not updates**: Every report should make clear what decisions are needed, from whom, and by when. Status without asks is just noise.
- **Quantify progress**: "Sprint velocity: 34 points (target: 30). 4 of 6 epics complete. On track for Phase 2 milestone on April 1."
- **Concise**: Weekly updates should be scannable in 2 minutes. Steering committee summaries in 5 minutes. If it's longer, cut it.

### Step 4: Format and Deliver

Output as a structured Markdown document matching the appropriate format example. Use Baufest voice: precise, confident, forward-looking.

## Output Format

A structured Markdown document matching the selected report type. Each report has standardized sections for consistency across projects. Typical length: 1 page (weekly) to 3 pages (steering committee).

## References

- See [weekly-update.md](examples/weekly-update.md) for weekly status report format
- See [steering-committee.md](examples/steering-committee.md) for governance meeting summary format
