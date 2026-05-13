# Handoff — 01_lead_qualifier

## What I Receive

**From:** `00_orchestrator`
**Schema:** `_schemas/routing_decision.json` in `_schemas/handoff_envelope.json`
**Required fields:** `classification`, `assigned_agent`, `client_type`, `context.ghl_contact_id`

If `classification` is not `new_lead` → return to orchestrator. Wrong specialist.
If `assigned_agent` is missing → escalate. I cannot proceed without an agent owner.

## What I Produce

### Path A — Active lead
**To:** `02_property_research`
**Schema:** `_schemas/qualified_lead.json`
**Trigger:** `lead_status: "active"` AND all required qualifying fields populated

### Path B — Nurture lead
**To:** `03_client_communication`
**Schema:** `_schemas/qualified_lead.json` with `lead_status: "nurture"`
**Trigger:** Timeline > 90 days or missing fields after 3 attempts

### Path C — Escalation
**To:** `00_orchestrator`
**Schema:** `_schemas/escalation.json`
**Trigger:** Rule 0 fires — cannot qualify, ambiguous intent, or agent reassignment requested

## Failure Modes

| What goes wrong | What I do |
|---|---|
| Prospect won't give budget after 3 asks | Note "undisclosed", proceed with nurture status |
| Prospect requests different agent | Escalate — do not reassign |
| Prospect speaks Spanish | Switch to Spanish, set `language: "es"` |
| Financing status unknown after asking | Set `financing_status: "unknown"`, flag for agent |
| Duplicate lead detected | Flag in notes, route to existing thread |

## The Handoff Envelope

```json
{
  "envelope": {
    "case_id": "carried from orchestrator — never changed",
    "handoff_id": "new uuid for this handoff",
    "from": "01_lead_qualifier",
    "to": "02_property_research | 03_client_communication | 00_orchestrator",
    "timestamp": "ISO 8601",
    "trigger": "Plain-English reason",
    "agent_owner": "carried from orchestrator — never changed",
    "schema_version": "v1"
  },
  "payload": "qualified_lead.json shape"
}
```

## What Happens Next

- **Active leads** → Property research pulls comps and neighborhood data, produces a research brief
- **Nurture leads** → Client communication drafts a warm, low-pressure first touch; GHL schedules follow-up
- **Unqualified leads** → Closed politely; GHL contact tagged accordingly
