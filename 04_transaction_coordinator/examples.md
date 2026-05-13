# Examples — 04_transaction_coordinator

## Example 1 — New Contract Received, Dates Loaded

**Input received:** signed_contract_handoff.json from 03_client_communication.
Deal: Marcus Thompson buying 2847 Barton Springs Rd. Contract price $472k. Closing date June 15.

**What I do:**
1. Load all key dates into GHL with advance alerts
2. Build document checklist — flag outstanding items
3. Confirm option fee and earnest money received
4. Update GHL pipeline: New Contract

**Output — GHL task list created:**
```
✅ Earnest money received — $5,000
✅ Option fee received — $200
⏳ Inspection scheduled — due by May 20 [ALERT set May 18]
⏳ Financing commitment — due June 1 [ALERT set May 27]
⏳ Appraisal ordered — due June 5 [ALERT set June 2]
⏳ Title commitment — due June 8
⏳ Final walkthrough — June 14
⏳ Closing — June 15
```

**Trigger to client_communication:** `scenario_type: milestone_update` — "Under contract — congratulations message to buyer."

---

## Example 2 — Inspection Issue Detected

**Situation:** Inspection report received. HVAC needs full replacement. Estimated $10,000.

**What I do:**
1. Flag risk: deal-affecting repair found
2. Request mid-deal research: repair cost estimate and comps with similar issues
3. Determine recommended position based on research: request $9,000 credit
4. Trigger client_communication with recommended position

**Output to 02_property_research:**
```json
{
  "research_type": "repair_cost_estimate",
  "urgency": "within_24h",
  "context": "Inspection found HVAC replacement needed. Need Austin market cost range and comparable deals with repair credits.",
  "deadline_at_risk": "2026-05-20"
}
```

**Output to 03_client_communication (after research returns):**
```json
{
  "scenario_type": "inspection_issue",
  "deal_context": {
    "scenario_details": "HVAC replacement needed, estimated $9,000-$12,000.",
    "recommended_position": "Request $9,000 credit. Leaves room for negotiation while protecting buyer."
  }
}
```

---

## Example 3 — Rule 0 Refusal (Missing Key Dates)

**Input received:** signed_contract_handoff.json with no closing_date.

**What I do:**
Apply Rule 0. Cannot coordinate without a closing date.

**Output:**
```json
{
  "escalated_by": "04_transaction_coordinator",
  "escalation_type": "missing_required_fields",
  "reason": "signed_contract_handoff received without closing_date. Cannot load deadline alerts or manage transaction without this field.",
  "to": "assigned_agent",
  "urgency": "blocking"
}
```
