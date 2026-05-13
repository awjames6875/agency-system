# Full Buyer Journey — Marcus Thompson

A complete walkthrough of a buyer request from first contact to under contract. Shows all 5 specialists in action with real handoff payloads.

---

## Day 1 — Inbound Phone Call

**Channel:** ghl voice bot voice bot answers call at 9:14 AM
**Caller:** Marcus Thompson, looking to buy in South Austin

ghl voice bot creates GHL contact `ghl_ct_9821` and sends call summary to `00_orchestrator`.

**Orchestrator produces:**
- case_id: `a3f7c2d1` ← follows this deal all the way to close
- Classification: new_lead, buyer
- Assigned agent: Sarah (round-robin)
- Routes to: `01_lead_qualifier`

---

## Day 1 — Lead Qualification (10 minutes)

**01_lead_qualifier** contacts Marcus via phone (preferred contact).

Questions asked one at a time:
- Intent: buy ✓
- Location: South Austin ✓
- Budget: $400-500k ✓
- Timeline: "want to be in by summer" → ~60 days → active ✓
- Financing: pre-approved at $475k ✓

**Qualifier produces** `qualified_lead.json` → routes to `02_property_research`

lead_status: **active**

---

## Day 1 — Property Research (2 hours)

**02_property_research** pulls:
- 5 recent comparable sales in 78704 and 78745
- Average: $447k, 18 days on market
- Market temp: warm
- School ratings: B to A- range
- Red flag: flood zone in parts of 78745 near Onion Creek

**Research produces** `research_brief.json` with 4 agent talking points → routes to `03_client_communication`

---

## Day 1 — First Outreach

**03_client_communication** receives research brief.
scenario_type: initial_outreach
Channel: text (Marcus's preference)
Voice: Sarah

**Draft produced:**
```
Hey Marcus! This is Sarah with Diana's team — excited to help you find your place in South Austin.
I've pulled some great options in your range. Want to jump on a quick call this week to go through them?
```

Sarah reviews → sends ✓

---

## Week 2 — Showings

Marcus tours 4 properties. Sarah uses research brief talking points in each showing.

After 2847 Barton Springs Rd: Marcus wants to make an offer.

Sarah requests comps for that specific property via GHL → `00_orchestrator` classifies as research_request → `02_property_research` produces targeted brief.

---

## Week 2 — Offer and Competing Offer

Offer submitted at $465k. Competing offer received same day.

**04_transaction_coordinator** is notified (monitoring the thread).

TC requests mid-deal research: competing offer analysis.
TC determines recommended position: $472k, 7-day close.

TC triggers `03_client_communication`:
- scenario_type: competing_offer
- recommended_position: "$472k, 7-day close"

**Draft produced** (Marcus's voice — wait, this is Sarah's client):
```
Subject: Update on 2847 Barton Springs — Competing Offer Received

Hi Marcus, another offer came in on Barton Springs. My recommendation: go to $472,000 
with a 7-day close. This puts you in the strongest position without overextending.

I need your go-ahead by end of day. Call me anytime.

Sarah
```

Sarah reviews → sends ✓
Marcus agrees → offer accepted.

---

## Week 2 — Contract Executed

Contract signed. `03_client_communication` produces `signed_contract_handoff.json`.

Routes to `04_transaction_coordinator`.

case_id `a3f7c2d1` is now in TC's hands. It has been on every single handoff since the ghl voice bot call.

---

## Weeks 3-6 — Transaction Coordination

**04_transaction_coordinator** loads all dates:
- Option period: May 20 [alert set May 18]
- Inspection: May 20 [alert set May 17]
- Financing: June 1 [alert set May 27]
- Appraisal: June 5 [alert set June 2]
- Closing: June 15

Inspection finds HVAC issue → TC requests research → TC triggers client comm with recommended position → Sarah sends message → $9,000 credit negotiated.

Appraisal comes in at $470k (under contract price of $472k) → TC flags appraisal gap → TC triggers client comm → Sarah communicates options to Marcus.

Financing clears June 1. Clear to close June 10.

**TC milestone trigger:** scenario_type: milestone_update → "Clear to close — draft celebration message."

---

## June 15 — Closing Day

Deal closes. TC updates GHL pipeline to Closed.

Final milestone trigger → `03_client_communication` → "Congratulations on your new home" message in Sarah's voice.

Marcus Thompson is now a closed client and a referral source.

---

## What Made This Work

Every specialist did exactly one job. Every handoff carried the same case_id. Sarah never had to ask "whose lead is this?" or "what happened on this deal?" — it was all in GHL, tracked by the TC, communicated by the comm specialist.

The newest agent on Diana's team could have run this deal from day one.
