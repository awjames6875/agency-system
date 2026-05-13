# Handoff — 03_client_communication

## What I Receive

**From:** `02_property_research` OR `04_transaction_coordinator` OR `00_orchestrator` (direct comm request)
**Schema:** `_schemas/research_brief.json` OR `_schemas/client_communication_trigger.json`
**Required fields:** `scenario_type`, `client_context.assigned_agent`, `client_context.preferred_contact`

If `scenario_type` is missing → Rule 0, escalate.
If `recommended_position` is empty on a competing_offer scenario → draft with placeholder, flag for agent.

## What I Produce

**To:** Agent (for review and send) — this is a terminal handoff for most scenarios
**To:** `04_transaction_coordinator` — when a deal goes under contract (signed_contract_handoff)
**Schema:** Draft message (formatted for channel) + `_schemas/signed_contract_handoff.json` when applicable

## When I Hand to Transaction Coordinator

When an offer is accepted and contract is signed, I produce `signed_contract_handoff.json` and route to `04_transaction_coordinator`. This is the trigger that moves the deal from active communication into active deal management.

## Failure Modes

| What goes wrong | What I do |
|---|---|
| Missing scenario_type | Rule 0 — escalate, do not draft |
| Missing recommended_position on competing_offer | Draft with placeholder, flag urgently |
| Client language unknown | Default to English, note uncertainty |
| Agent voice not established | Use professional neutral tone, flag for agent style review |

## Handoff Envelope

```json
{
  "envelope": {
    "case_id": "carried — never changed",
    "from": "03_client_communication",
    "to": "04_transaction_coordinator",
    "trigger": "Contract signed — transferring to transaction coordinator",
    "agent_owner": "carried — never changed"
  },
  "payload": "signed_contract_handoff.json shape — see _schemas/"
}
```
