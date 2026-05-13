# Examples — 00_orchestrator

## Example 1 — New Buyer Lead via ghl voice bot Call

**Input received:**
```json
{
  "source": "ghl voice bot_call",
  "raw_content": "Hi my name is Marcus Thompson, looking to buy in South Austin, budget 400-500k, want to be in by summer.",
  "contact": { "name": "Marcus Thompson", "phone": "512-555-0142", "ghl_contact_id": "ghl_ct_9821" },
  "ghl voice bot_call_summary": "Buyer, South Austin, $400-500k, summer timeline."
}
```

**What I do:**
1. Generate case_id: `a3f7c2d1-9b4e-4f2a-8c1d-3e5f7a9b0c2d`
2. Classify: `new_lead` — clear buyer intent, location and budget stated
3. Assign agent: Sarah (next in round-robin)
4. Confidence: 0.92
5. Route to: `01_lead_qualifier`

**Output produced:**
```json
{
  "envelope": {
    "case_id": "a3f7c2d1-9b4e-4f2a-8c1d-3e5f7a9b0c2d",
    "handoff_id": "h_001",
    "from": "00_orchestrator",
    "to": "01_lead_qualifier",
    "timestamp": "2026-05-13T09:14:00Z",
    "trigger": "New buyer lead via ghl voice bot, qualifying context present",
    "agent_owner": "agent_sarah",
    "schema_version": "v1"
  },
  "payload": {
    "classification": "new_lead",
    "client_type": "buyer",
    "confidence": 0.92,
    "assigned_agent": "agent_sarah",
    "context": { "ghl_contact_id": "ghl_ct_9821" }
  }
}
```

---

## Example 2 — Existing Client Requests Property Research

**Input received:**
```json
{
  "source": "sms",
  "raw_content": "Hey can you pull comps for 2847 Barton Springs Rd? Going to make an offer this week.",
  "contact": { "name": "Jennifer Wu", "phone": "512-555-0198", "ghl_contact_id": "ghl_ct_4471" }
}
```

**What I do:**
1. Existing thread found — Jennifer is active buyer, Marcus is assigned agent
2. Classify: `research_request` — specific property, offer timeline
3. Assign agent: Marcus (existing owner, no change)
4. Confidence: 0.88
5. Route to: `02_property_research`

**Output produced:**
```json
{
  "envelope": {
    "case_id": "b7e2a1f4-existing-thread",
    "handoff_id": "h_047",
    "from": "00_orchestrator",
    "to": "02_property_research",
    "timestamp": "2026-05-13T14:22:00Z",
    "trigger": "Existing buyer requesting comps before offer",
    "agent_owner": "agent_marcus",
    "schema_version": "v1"
  },
  "payload": {
    "classification": "research_request",
    "client_type": "buyer",
    "confidence": 0.88,
    "assigned_agent": "agent_marcus",
    "context": { "ghl_contact_id": "ghl_ct_4471", "existing_lead": true }
  }
}
```

---

## Example 3 — Rule 0 Refusal (Cannot Classify)

**Input received:**
```json
{
  "source": "sms",
  "raw_content": "Hey it's Dave. Wanted to follow up on that thing we talked about.",
  "contact": { "name": "Dave", "phone": "512-555-0317", "ghl_contact_id": null }
}
```

**What I do:**
Apply Rule 0. Cannot classify — no context, no GHL record, confidence 0.21. Escalate to Diana.

**Output produced:**
```json
{
  "envelope": {
    "case_id": "new",
    "handoff_id": "esc_012",
    "from": "00_orchestrator",
    "to": "00_orchestrator",
    "timestamp": "2026-05-13T16:05:00Z",
    "trigger": "Cannot classify — insufficient context",
    "agent_owner": "diana",
    "schema_version": "v1"
  },
  "payload": {
    "escalated_by": "00_orchestrator",
    "escalation_type": "low_confidence_routing",
    "reason": "Contact unknown, no GHL record, message too vague to classify.",
    "to": "diana",
    "urgency": "normal"
  }
}
```
