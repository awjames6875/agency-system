# Agency System — AI Operating System for Diana's Real Estate Team

A multi-agent ICM (Interpretable Context Methodology) system for a 4-person boutique real estate team in Austin. 60-80 transactions/year. Designed so any team member — including a new agent on day one — is operational without help.

---

## The 60-Second Version

Diana's team was running on duct tape — leads falling through cracks, agents not knowing whose job it was, new agents Slacking at 11pm asking which document goes where.

This system fixes that. Five AI specialists. Each one owns a distinct part of the workflow. Each one passes work to the next one through an explicit, typed handoff contract.

No lead falls through the cracks. No agent guesses whose job it is. New agent is operational in a day.

---

## Architecture

```
Inbound (GHL form / ghl voice bot call / SMS / chat)
         ↓
   00_orchestrator          ← Front door. Routes everything.
    ↙    ↓    ↘    ↘
01_lq  02_pr  03_cc  04_tc  ← Specialists. Each owns one domain.
    ↘    ↓    ↗
   (handoffs flow forward and back via typed JSON contracts)
```

**Every arrow is a contract.** See `_schemas/` for all 10 handoff schemas.

---

## The 5 Specialists

| Folder | What it does | Hands to |
|---|---|---|
| `00_orchestrator/` | Receives all inbound, classifies, assigns agent, routes | Any specialist |
| `01_lead_qualifier/` | Captures intent, budget, timeline, financing status | `02_property_research` (active) or `03_client_communication` (nurture) |
| `02_property_research/` | Pulls comps, neighborhood data, red flags, talking points | `03_client_communication` |
| `03_client_communication/` | Drafts messages in the assigned agent's voice | `04_transaction_coordinator` (on contract) |
| `04_transaction_coordinator/` | Owns active deals: deadlines, documents, risk flags | `03_client_communication` and `02_property_research` mid-deal |

---

## A Typical Buyer Request (Start to Finish)

1. **Phone call comes in** → GHL voice bot answers, creates GHL contact, sends call summary to `00_orchestrator`
2. **Orchestrator classifies** → new buyer lead → assigns Agent Sarah → sets case_id → routes to `01_lead_qualifier`
3. **Lead qualifier** → captures budget ($400-500k), location (South Austin), timeline (60 days), pre-approved → `lead_status: active` → passes `qualified_lead.json` to `02_property_research`
4. **Property research** → pulls South Austin comps, school ratings, flags flood zone risk, writes talking points → passes `research_brief.json` to `03_client_communication`
5. **Client communication** → drafts a personal text in Sarah's voice → Sarah reviews and sends
6. **Showings happen → offer accepted → contract signed** → `03_client_communication` passes `signed_contract_handoff.json` to `04_transaction_coordinator`
7. **Transaction coordinator** → loads all deadlines into GHL, tracks every document, triggers client updates at each milestone → deal closes

The `case_id` set in step 2 travels through every one of these handoffs unchanged. Every specialist can see they're working the same case.

---

## How to Onboard a New Team Member

1. Read `CLAUDE.md` — the master routing table
2. Read `_onboarding/DAY_ONE.md` — the complete day-one guide
3. Pick a scenario from `_examples/` and walk through it
4. Open the relevant specialist folder and read its 4 files

If you've done those four things, you can operate this system. That's the bar.

---

## The Handoff Contracts

The `_schemas/` folder contains 10 JSON schemas. Every handoff in this system validates against one of them.

| Schema | What it defines |
|---|---|
| `handoff_envelope.json` | Wrapper around every payload — case_id, from, to, agent_owner |
| `inbound_request.json` | External → orchestrator |
| `routing_decision.json` | Orchestrator → any specialist |
| `qualified_lead.json` | Lead qualifier → property research |
| `research_brief.json` | Property research → client communication |
| `client_communication_trigger.json` | TC → client communication (8 scenario types) |
| `signed_contract_handoff.json` | Client comm → transaction coordinator |
| `mid_deal_research_request.json` | TC → property research |
| `escalation.json` | Any specialist → orchestrator (Rule 0) |
| `seller_lead_v2_stub.json` | Seller path — documented for v2 |

---

## Design Decisions

**Agent assignment lives in the orchestrator, not the qualifier.**
Assignment is a business policy decision — who owns this client relationship. It is separate from qualifying logic. Setting it once at the router keeps ownership clean for the entire transaction lifecycle.

**GHL as the runtime, not a custom web app.**
Real estate teams use CRMs. Diana's team uses GoHighLevel. The deployment layer meets the team where they already work.

**Buyer-only v1, seller path stubbed honestly.**
Building both buyer and seller paths fully in one week would have compromised the quality of both. The buyer path is production-ready. The seller path is architecturally supported (client_type field exists in every schema) and documented in `seller_lead_v2_stub.json`.

**JSON schemas as handoff contracts.**
Most multi-agent systems define handoffs as prose descriptions. This system defines them as typed JSON schemas. A prose description can drift. A schema breaks at the point of violation — which is exactly what you want in a production system.

---

## Setup

1. Drop this repo into a Claude Project
2. Add `CLAUDE.md` as project knowledge
3. Add your agent names to the `agent_owner` enum in `_schemas/handoff_envelope.json`
4. Set up GHL pipeline stages: `New Lead → Qualified → Research Done → Outreach Active → Under Contract → Closed`
5. Configure GHL voice bot using `_deployment/ghl_voice_config.md`
6. Full GHL setup guide: `_deployment/ghl_setup.md`

---

## Built With

- ICM (Interpretable Context Methodology) — Jake Van Clief
- Bootstrapped using `icm-multi-agent-bootstrap` — a reusable skill that generates this architecture for any team in any industry. This system is its first production output.
- GoHighLevel + ghl voice bot for the deployment layer
- Austin, TX residential real estate as the domain

---

*Clief Notes Weekly Competition #4 — May 2026*
