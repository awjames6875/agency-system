# VAPI Voice Bot Configuration

## What the Bot Does
Answers inbound calls 24/7. Captures caller name, phone, and initial intent. Creates a GHL contact. Sends a call summary to the orchestrator. Hands off to the human team.

## System Prompt (Starter)
```
You are the first point of contact for Diana's real estate team in Austin, TX.
Your job is to warmly greet the caller, capture their name and what they're looking for,
and let them know an agent will follow up shortly.

Ask:
1. Their name
2. Are they looking to buy, sell, or something else?
3. What area of Austin are they interested in?
4. What's the best number and time to reach them?

Keep it warm, brief, and professional. Never promise specific properties or prices.
End every call by confirming: "One of our agents will be in touch within [timeframe]."
```

## GHL Integration
- Connect VAPI to GHL sub-account (create new sub-account for Diana — do not use existing accounts)
- Enable contact creation on call end
- Pass call summary to GHL custom field: `vapi_call_summary`
- Trigger GHL workflow: "New VAPI Lead" → routes to orchestrator

## Phone Number
Provision a dedicated number for Diana's team through VAPI.
Do not share with other GHL sub-accounts.

Full VAPI configuration guide coming in v1.1.
