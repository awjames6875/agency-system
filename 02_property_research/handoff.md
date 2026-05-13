# Handoff — 02_property_research

## What I Receive

**From:** `01_lead_qualifier` (new lead path) OR `04_transaction_coordinator` (mid-deal path)

**Schema:** `_schemas/qualified_lead.json` OR `_schemas/mid_deal_research_request.json`

**Required fields:**
- From qualifier: `intent.client_type`, `intent.buyer_fields.locations` or seller property address
- From TC: `deal_id`, `research_type`, `urgency`

If subject is missing → Rule 0, escalate.

## What I Produce

**To:** `03_client_communication`
**Schema:** `_schemas/research_brief.json`
**Trigger:** Research complete, talking points ready, red flags documented

## Failure Modes

| What goes wrong | What I do |
|---|---|
| No comparables found | State clearly in brief — do not fabricate |
| Red flag discovered mid-research | Include in brief regardless of scope |
| Urgency = immediate but queue is full | Immediate always jumps queue |
| Mid-deal research deadline at risk | Alert TC in payload with `deadline_at_risk` field |

## Handoff Envelope

```json
{
  "envelope": {
    "case_id": "carried from original thread",
    "from": "02_property_research",
    "to": "03_client_communication",
    "trigger": "Research brief complete",
    "agent_owner": "carried — never changed"
  },
  "payload": "research_brief.json shape — see _schemas/"
}
```
