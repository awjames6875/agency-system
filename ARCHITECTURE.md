# Architecture

## System Shape
Hub-and-spoke with bidirectional mid-deal flows. The orchestrator is the hub. Five specialists are the spokes. Work flows forward through the typical buyer/seller lifecycle, and flows back when active deals need research or client communication.

## Request Lifecycle

```
INBOUND (GHL form / VAPI call / SMS / chat / manual)
    │
    ▼
┌─────────────────────────────────┐
│         00_orchestrator         │  ← Sets case_id. Assigns agent. Routes.
│  classify → assign → route      │
└────┬────────┬────────┬──────────┘
     │        │        │
     ▼        ▼        ▼
┌────────┐  ┌──────────────────┐  ┌─────────────────┐
│ 01     │  │ 02               │  │ 03              │
│ lead   │  │ property         │  │ client          │
│qualify │  │ research         │  │ communication   │
└───┬────┘  └────────┬─────────┘  └────┬────────────┘
    │                │                  │
    │ qualified_lead │ research_brief   │ signed_contract
    └───────────────►└─────────────────►│
                                        │
                                        ▼
                              ┌─────────────────────┐
                              │ 04                  │
                              │ transaction         │
                              │ coordinator         │
                              └──┬──────────────────┘
                                 │ mid-deal triggers
                                 ├──────────────────► 03_client_communication
                                 └──────────────────► 02_property_research
```

## The Handoff Contracts

Every arrow in the diagram above is a typed JSON contract. All schemas live in `_schemas/`.

The `handoff_envelope.json` wraps every payload:
- `case_id` — set once at orchestrator, never changes
- `handoff_id` — unique per handoff, used for tracing
- `agent_owner` — set once at orchestrator, never changes
- `from` / `to` — specialist folder names
- `trigger` — plain English reason this handoff fired

## Key Design Decisions

### 1. case_id tracks the full thread
Every handoff in a transaction carries the same `case_id` from first contact to close. Any specialist can verify they're working the same case.

### 2. Agent assignment at orchestrator level
The `assigned_agent` field is set once — at the orchestrator — and carried through every downstream handoff unchanged. This is intentional. Assignment is a business policy decision, not a qualifying decision.

### 3. GHL as the runtime
GoHighLevel is the CRM Diana's team already uses. The deployment layer mirrors GHL pipeline stages to specialist progression:
- New Lead → 01_lead_qualifier active
- Qualified → 02_property_research complete
- Research Done → 03_client_communication outreach sent
- Outreach Active → conversation in progress
- Under Contract → 04_transaction_coordinator owns it
- Closed → deal complete

### 4. Buyer v1, Seller v2
The `client_type` field is present in every handoff schema. Seller routing is architecturally supported. The v1 demo is buyer-only. See `_schemas/seller_lead_v2_stub.json`.

### 5. Rule 0 in every specialist
Every specialist has a Rule 0 — a specific, concrete condition under which it refuses to proceed and escalates. These are not labels. They are real refusal mechanisms that block output when required fields are missing or confidence thresholds are not met.
