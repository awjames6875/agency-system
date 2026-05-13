# Handoff — 00_orchestrator

## What I Receive

**From:** External (GHL form, ghl voice bot call, GHL chat, SMS, email, manual agent entry)
**Schema:** `_schemas/inbound_request.json`
**Required fields:** `source`, `raw_content`, `timestamp`
**Optional fields:** `contact.name`, `contact.phone`, `contact.ghl_contact_id`, `ghl voice bot_call_summary`, `language`

If source is `ghl voice bot_call` and no call summary is present → escalate. I cannot classify a call without a summary.

## What I Produce

**To:** One of: `01_lead_qualifier`, `02_property_research`, `03_client_communication`, `04_transaction_coordinator`
**Schema:** `_schemas/routing_decision.json` wrapped in `_schemas/handoff_envelope.json`
**Required fields:** `case_id`, `classification`, `routed_to`, `assigned_agent`, `client_type`, `confidence`
**Trigger condition:** Classification confidence ≥ 0.70

**Also produces (when Rule 0 fires):**
**To:** Human (Diana or assigned agent)
**Schema:** `_schemas/escalation.json`

## Failure Modes

| What goes wrong | What I do |
|---|---|
| Confidence < 0.70 | Escalate to assigned agent with classification attempt and reason |
| No GHL contact ID on inbound | Proceed with routing, flag missing ID in payload |
| ghl voice bot call with no summary | Escalate to Diana — cannot classify without transcript |
| Duplicate contact detected | Route to existing thread owner, flag as duplicate |
| Spanish-language inbound | Route normally, set `language: "es"` in payload |
| Source unknown | Treat as `manual_agent_entry`, classify from content alone |

## The Handoff Envelope

Every payload I produce is wrapped in this envelope:

```json
{
  "envelope": {
    "case_id": "uuid — set once here, never changes",
    "handoff_id": "uuid — unique to this handoff",
    "from": "00_orchestrator",
    "to": "01_lead_qualifier | 02_property_research | 03_client_communication | 04_transaction_coordinator",
    "timestamp": "ISO 8601",
    "trigger": "Plain-English reason this handoff fired",
    "agent_owner": "diana | agent_sarah | agent_marcus | agent_new",
    "schema_version": "v1",
    "ghl_contact_id": "string — ties back to CRM record"
  },
  "payload": {
    "classification": "new_lead | research_request | comm_request | active_deal",
    "routed_to": "folder name",
    "assigned_agent": "set here, never changes downstream",
    "client_type": "buyer | seller | unknown",
    "confidence": 0.00,
    "context": {}
  }
}
```

## Design Decision

Agent assignment lives here — not inside the qualifier. Assignment is a business policy decision (who owns this client relationship) that is separate from qualifying logic (what does this client need). Mixing them creates reassignment drift. Setting it once at the orchestrator level keeps ownership clean for the entire transaction lifecycle.
