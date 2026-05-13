# Examples — 01_lead_qualifier

## Example 1 — Active Buyer, Fully Qualified

**Input received:**
```json
{
  "envelope": { "case_id": "a3f7c2d1", "agent_owner": "agent_sarah" },
  "payload": {
    "classification": "new_lead",
    "client_type": "buyer",
    "context": { "ghl_contact_id": "ghl_ct_9821" },
    "raw_content": "Looking to buy in South Austin, budget 400-500k, want to be in by summer."
  }
}
```

**What I do:**
1. Confirm intent: buyer ✓
2. Capture budget: $400k–$500k ✓
3. Capture timeline: summer = ~60 days → active ✓
4. Capture location: South Austin ✓
5. Ask financing status: "Are you already working with a lender?" → "Yes, pre-approved at $475k" ✓
6. Lead status: active — all required fields populated

**Output produced:**
```json
{
  "envelope": {
    "case_id": "a3f7c2d1",
    "handoff_id": "h_002",
    "from": "01_lead_qualifier",
    "to": "02_property_research",
    "trigger": "Buyer fully qualified — active status, all fields populated",
    "agent_owner": "agent_sarah",
    "schema_version": "v1"
  },
  "payload": {
    "prospect": {
      "name": "Marcus Thompson",
      "phone": "512-555-0142",
      "preferred_contact": "phone",
      "language": "en",
      "ghl_contact_id": "ghl_ct_9821"
    },
    "intent": {
      "client_type": "buyer",
      "buyer_fields": {
        "budget_min": 400000,
        "budget_max": 500000,
        "locations": ["South Austin"],
        "timeline_days": 60,
        "financing_status": "pre_approved"
      }
    },
    "lead_status": "active",
    "assigned_agent": "agent_sarah"
  }
}
```

---

## Example 2 — Nurture Lead (Timeline Too Long)

**Input received:**
Prospect via GHL form: interested in buying, but "probably in about a year, just starting to look."

**What I do:**
1. Confirm intent: buyer ✓
2. Budget: "around $350k" ✓
3. Timeline: ~365 days → nurture threshold exceeded
4. Lead status: nurture
5. Set next_touchpoint: 90 days from today

**Output produced:**
```json
{
  "envelope": {
    "case_id": "c9d4e2f1",
    "handoff_id": "h_003",
    "from": "01_lead_qualifier",
    "to": "03_client_communication",
    "trigger": "Nurture lead — timeline 365 days, schedule check-in",
    "agent_owner": "agent_marcus",
    "schema_version": "v1"
  },
  "payload": {
    "prospect": { "name": "Sandra Lee", "preferred_contact": "email" },
    "intent": {
      "client_type": "buyer",
      "buyer_fields": { "budget_max": 350000, "timeline_days": 365, "financing_status": "not_started" }
    },
    "lead_status": "nurture",
    "next_touchpoint": "2026-08-13T09:00:00Z",
    "qualification_notes": "Early-stage buyer. Not urgent. Friendly touchpoint in 90 days.",
    "assigned_agent": "agent_marcus"
  }
}
```

---

## Example 3 — Rule 0 Refusal (Cannot Qualify After 3 Attempts)

**Input received:**
Prospect via ghl voice bot call. Vague answers. Won't state budget or timeline after 3 attempts.

**What I do:**
Apply Rule 0. Cannot qualify. Set lead_status: nurture, next_touchpoint in 30 days. Escalate note to assigned agent.

**Output produced:**
```json
{
  "envelope": {
    "case_id": "d2e5f8a1",
    "handoff_id": "esc_003",
    "from": "01_lead_qualifier",
    "to": "00_orchestrator",
    "trigger": "Rule 0 — cannot qualify after 3 attempts",
    "agent_owner": "agent_new",
    "schema_version": "v1"
  },
  "payload": {
    "escalated_by": "01_lead_qualifier",
    "escalation_type": "missing_required_fields",
    "reason": "Prospect would not state budget or timeline after 3 attempts. Possible tire-kicker or not ready.",
    "to": "assigned_agent",
    "urgency": "normal",
    "partial_output": { "lead_status": "nurture", "next_touchpoint": "2026-06-13T09:00:00Z" }
  }
}
```
