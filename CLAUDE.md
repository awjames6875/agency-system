# CLAUDE.md — Diana's Agency AI Operating System

## What This Is
A multi-agent ICM system for a 4-person boutique real estate team in Austin. 60-80 transactions/year. Built so any team member — including a new agent on day one — can operate it without help.

Bootstrapped using `icm-multi-agent-bootstrap` — a reusable skill that generates this architecture for any team in any industry.

---

## Routing Table
Every request starts here. Read the request type, go to the right folder, read that folder's 4 files before generating output.

| Request type | Go to folder | Read these files |
|---|---|---|
| Any new inbound (always start here) | `00_orchestrator/` | All 4 files |
| New buyer or seller prospect | `01_lead_qualifier/` | identity.md → rules.md → examples.md → handoff.md |
| Property or neighborhood research needed | `02_property_research/` | identity.md → rules.md → examples.md → handoff.md |
| Drafting a message to a client | `03_client_communication/` | identity.md → rules.md → examples.md → handoff.md |
| Active deal, post-contract | `04_transaction_coordinator/` | identity.md → rules.md → examples.md → handoff.md |
| Any specialist hits Rule 0 | `_schemas/escalation.json` | Fill the schema, route to assigned human |

---

## Critical Rules (Apply Everywhere)

1. **Every request enters through `00_orchestrator/`.** No specialist is called directly unless the orchestrator has already classified and routed.
2. **Agent assignment happens at the orchestrator.** The `assigned_agent` field in `routing_decision.json` is set once and never changed inside a specialist.
3. **Every output that crosses a specialist boundary must match its schema.** See `_schemas/` for all 10 schema files.
4. **If a required field is missing, apply Rule 0.** Do not invent values. Do not guess. Escalate using `_schemas/escalation.json`.
5. **Never bleed context between folders.** If you are inside `02_property_research/`, do not apply rules from `03_client_communication/`.
6. **Buyer path is live (v1). Seller path is stubbed (v2).** If a seller comes in, qualify them, flag `client_type=seller`, and escalate to Diana until v2 ships.

---

## Team Directory
| Agent | GHL Tag | Voice Style |
|---|---|---|
| Diana | `agent_diana` | Authoritative, concise, Austin market expert |
| Sarah | `agent_sarah` | Warm, relationship-first, strong with first-time buyers |
| Marcus | `agent_marcus` | Data-driven, investment-minded, condo specialist |
| New agent | `agent_new` | Supervised — all escalations CC Diana until 6-month mark |

---

## Deployment Layer (GHL + ghl voice bot)
- **GHL Funnel:** `[your-domain.com]` — public demo URL, all inbound sources unified
- **ghl voice bot Voice Bot:** `[phone number]` — answers calls 24/7, creates GHL contacts, triggers inbound_request.json
- **GHL Pipeline:** 5 stages mirroring specialist progression: `New Lead → Qualified → Research Done → Outreach Active → Under Contract → Closed`
- **Setup guide:** See `_deployment/ghl_setup.md`

---

## ADHD-Friendly Operating Rules
- Number every step
- One task at a time
- Copy-paste ready output only
- Warn before irreversible actions
- End every major output with "you'll know this worked when X"
