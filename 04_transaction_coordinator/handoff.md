# Handoff — 04_transaction_coordinator

## What I Receive

**From:** `03_client_communication`
**Schema:** `_schemas/signed_contract_handoff.json`
**Required fields:** `deal_id`, `parties`, `property.address`, `property.contract_price`, `key_dates.contract_date`, `key_dates.closing_date`, `assigned_agent`

If `closing_date` is missing → Rule 0, escalate immediately. Blocking.

## What I Produce

### Path A — Client update needed
**To:** `03_client_communication`
**Schema:** `_schemas/client_communication_trigger.json`
**Trigger:** Milestone reached, deadline approaching, or mid-deal event (inspection, competing offer, financing delay)

### Path B — Additional research needed
**To:** `02_property_research`
**Schema:** `_schemas/mid_deal_research_request.json`
**Trigger:** Inspection finding, appraisal gap, title issue requiring data

### Path C — Escalation
**To:** `00_orchestrator`
**Schema:** `_schemas/escalation.json`
**Trigger:** Legal risk, agent dispute, deal-breaking event, or any situation requiring Diana's authority

## The Back-Handoff (Key Design Decision)

I am the only specialist that regularly sends work BACK to other specialists mid-deal. This is by design:
- **TC → Client Comm:** I know what happened in the deal; client_comm knows how to say it
- **TC → Research:** I know what question needs answering; research knows how to find the data

This bidirectional flow is what keeps a live deal running without requiring agent intervention for every update.

## Failure Modes

| What goes wrong | What I do |
|---|---|
| Missing closing date | Rule 0 — escalate immediately, blocking |
| Deadline missed | Escalate to Diana with full timeline and how we got here |
| Lender goes silent (3+ days) | Alert assigned agent, escalate if no response in 24h |
| Appraisal comes in low | Request research for gap analysis, trigger client comm |
| Title issue discovered | Escalate to Diana — legal territory |

## Handoff Envelope

```json
{
  "envelope": {
    "case_id": "carried from original thread — never changes",
    "from": "04_transaction_coordinator",
    "to": "03_client_communication | 02_property_research | 00_orchestrator",
    "trigger": "Plain-English reason",
    "agent_owner": "carried — never changed"
  },
  "payload": "client_communication_trigger.json OR mid_deal_research_request.json OR escalation.json"
}
```
