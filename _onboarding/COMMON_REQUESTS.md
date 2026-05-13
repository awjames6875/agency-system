# Common Requests — Quick Reference Guide

Use this when a request comes in and you need to know which specialist handles it and what to give them.

---

## 1. New Lead Just Called / Filled Out a Form

**Who handles it:** 00_orchestrator → 01_lead_qualifier
**What you do:** Nothing. The GHL voice bot or form captures the contact and routes it automatically.
**What to watch for:** Check GHL pipeline — the lead should appear in the "New Lead" stage within 2 minutes of contact.

---

## 2. Agent Asks: "Can You Research This Property?"

**Who handles it:** 02_property_research
**What you give it:**
- Property address
- Client name
- What the client wants to know (comps, neighborhood, schools, market trend)
- Assigned agent name

**What you get back:** A `research_brief` — a formatted document the agent can take straight into a client conversation.

---

## 3. Agent Asks: "Can You Draft a Message to My Client?"

**Who handles it:** 03_client_communication
**What you give it:**
- Client name and preferred contact method (text or email)
- Assigned agent name (the message will be written in their voice)
- Scenario — pick one:
  - Initial outreach
  - Post-showing follow-up
  - Missed showing
  - Competing offer situation
  - Inspection issue
  - Financing delay
  - Milestone update
  - Nurture check-in

**What you get back:** A drafted message, ready to review and send. Agent always reviews before sending.

---

## 4. A Deal Just Went Under Contract

**Who handles it:** 04_transaction_coordinator
**What you give it:** The signed contract handoff — client name, property address, key dates (close date, inspection deadline, financing deadline), assigned agent.
**What you get back:** A live deal in the TC pipeline with deadlines tracked and document checklist started.

---

## 5. Client Hasn't Heard From Us in a While (Nurture Lead)

**Who handles it:** 01_lead_qualifier flags it → GHL drip handles re-engagement
**What you do:** Check the lead's `lead_status` in GHL. If it says `nurture`, the system has a `next_touchpoint` date set. GHL will fire the re-engagement automatically.
**If you want to manually reach out:** Route to 03_client_communication with scenario type `nurture_check_in`.

---

## 6. Something Went Wrong Mid-Deal

**Who handles it:** 04_transaction_coordinator first. If it can't resolve it → escalation to Diana.
**Examples:** Missing document, blown deadline, title issue, financing falling apart.
**What you do:** Open the deal in GHL, add a note describing the problem. The TC specialist will flag it. If it needs Diana, an escalation fires automatically.

---

## 7. New Lead Speaks Spanish

**Who handles it:** 00_orchestrator flags it → 01_lead_qualifier handles from there.
**What the system does:** Orchestrator adds `language: "es"` to the routing payload. Lead qualifier is equipped to handle Spanish-language qualification.
**What you do:** Nothing extra. Just make sure the GHL contact record notes the preferred language.

---

## 8. Agent Wants to Know Where a Deal Stands

**Who handles it:** 04_transaction_coordinator
**What you do:** Check the GHL pipeline. Every active deal has a stage, a next deadline, and a document checklist. If something is missing or overdue, it will be flagged in the deal notes.

---

## Quick Cheat Sheet

| Request type | Starts at | Ends at |
|---|---|---|
| New inbound lead | 00_orchestrator | 01_lead_qualifier |
| Property research | 02_property_research | 03_client_communication |
| Draft a message | 03_client_communication | Agent review → send |
| Active deal update | 04_transaction_coordinator | Agent notified |
| Escalation / judgment call | Any specialist | Diana |
