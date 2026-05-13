# GHL Setup Guide

## Pipeline Stages
Create these 6 stages in your GHL pipeline (in order):

1. **New Lead** — Contact created, routed to lead qualifier
2. **Qualified** — Lead qualifier complete, active status
3. **Research Done** — Property research brief delivered to agent
4. **Outreach Active** — First message sent, client engaged
5. **Under Contract** — Signed contract, TC owns the deal
6. **Closed** — Deal complete

## Custom Fields to Create
Add these custom fields to your GHL contacts:

- `case_id` (text) — Set by orchestrator on first contact
- `assigned_agent` (dropdown: diana, agent_sarah, agent_marcus, agent_new)
- `client_type` (dropdown: buyer, seller, unknown)
- `lead_status` (dropdown: active, nurture, unqualified, closed)
- `budget_min` (number)
- `budget_max` (number)
- `timeline_days` (number)
- `financing_status` (dropdown: pre_approved, not_started, cash, unknown)
- `next_touchpoint` (date) — For nurture leads

## Inbound Channels to Connect
- GHL funnel form → webhook → orchestrator
- ghl voice bot voice bot → GHL contact creation → orchestrator
- GHL chat widget → orchestrator
- SMS reply → orchestrator

## Automation Workflows
Create deadline alert workflows for:
- Option period end (48h before)
- Inspection deadline (72h before)
- Financing deadline (5 days before)
- Appraisal deadline (72h before)
- Closing date (7 days, 48h, day-of)

Full setup walkthrough coming in v1.1.
