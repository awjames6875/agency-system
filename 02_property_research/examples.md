# Examples — 02_property_research

## Example 1 — Buyer Neighborhood Research

**Input received:** Qualified buyer, South Austin, $400-500k, summer timeline.

**What I do:**
1. Pull recent sales in South Austin, $380k-$520k range, last 90 days
2. Calculate avg price/sqft, avg days on market
3. Note market temperature: warm (inventory low, homes moving in 18 days avg)
4. Check school ratings for target zip codes
5. Surface any red flags (flood zone areas in South Austin near Onion Creek)
6. Write 4 talking points for Sarah

**Output produced:**
```json
{
  "envelope": {
    "case_id": "a3f7c2d1",
    "handoff_id": "h_003",
    "from": "02_property_research",
    "to": "03_client_communication",
    "trigger": "Research brief complete for active buyer",
    "agent_owner": "agent_sarah",
    "schema_version": "v1"
  },
  "payload": {
    "subject": "South Austin — $400-500k buyer search",
    "brief_type": "buyer_neighborhood",
    "findings": {
      "price_range": { "low": 385000, "high": 510000, "recommended": 445000 },
      "avg_days_on_market": 18,
      "market_temp": "warm",
      "neighborhood_summary": "South Austin remains highly competitive. 78704 and 78745 are the target zips. Walkable to South Congress, strong rental demand, consistent appreciation.",
      "school_ratings": { "elementary": "B", "middle": "B+", "high": "A-", "rating_source": "GreatSchools" },
      "red_flags": ["Parts of 78745 near Onion Creek are in FEMA flood zone AE — verify address-by-address"],
      "talking_points": [
        "Homes in this range are moving fast — 18 days average. Pre-approval letter needs to be ready to submit same day.",
        "Budget aligns well with the market. $450k is the sweet spot for 3BR in 78745.",
        "South Congress corridor adds 10-15% premium — if walkability matters, budget accordingly.",
        "Flood zone check is mandatory before any offer in 78745 south of Ben White."
      ]
    },
    "assigned_agent": "agent_sarah"
  }
}
```

---

## Example 2 — Mid-Deal Research (Inspection Issue)

**Input received:** TC requests repair cost estimate after inspection found HVAC needs replacement.

**What I do:**
1. Research Austin HVAC replacement costs (2025-2026 market)
2. Pull 3 recent comparable sales with HVAC repair credits negotiated
3. Assess typical seller response: full replacement vs. credit
4. Return findings with urgency: within_24h

**Output produced:**
```json
{
  "payload": {
    "subject": "HVAC replacement — mid-deal research",
    "brief_type": "buyer_property",
    "findings": {
      "red_flags": ["HVAC full replacement estimate: $8,000-$12,000 Austin market 2026"],
      "talking_points": [
        "Comparable deals: sellers typically offer $6,000-$8,000 credit rather than replacement.",
        "Buyer position: request $10,000 credit or price reduction — leaves negotiation room.",
        "If seller refuses, option period allows walkaway without penalty until [deadline]."
      ]
    }
  }
}
```

---

## Example 3 — Rule 0 Refusal (No Subject Provided)

**Input received:** Research request with no property address or neighborhood — just "buyer needs research."

**What I do:**
Apply Rule 0. No subject = cannot research. Escalate back to orchestrator.

**Output:** escalation.json with reason: "Research request missing subject. Cannot pull comps without property address or target neighborhood."
