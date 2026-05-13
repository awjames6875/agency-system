# Examples — 03_client_communication

## Example 1 — Initial Outreach (Buyer, Text, Sarah's Voice)

**Input received:** Research brief complete for Marcus Thompson, South Austin buyer, prefers text.

**What I do:**
1. scenario_type: initial_outreach
2. Channel: text → conversational, 1-2 sentences
3. Voice: Sarah — warm, personal, reference something specific

**Draft produced:**
```
Hey Marcus! This is Sarah with Diana's team — so excited to help you find your place in South Austin. 
I pulled some great options in your budget. Want to jump on a quick call this week to go through them?
```

---

## Example 2 — Competing Offer (Email, Marcus's Voice)

**Input received:** TC trigger — competing offer received on Jennifer Wu's target property.
`recommended_position: "Escalate to highest and best — recommend $472k with 7-day close."`

**What I do:**
1. scenario_type: competing_offer
2. Channel: email → professional, 3-5 sentences
3. Voice: Marcus — direct, data-forward
4. Include recommended position

**Draft produced:**
```
Subject: Update on 2847 Barton Springs — Competing Offer Received

Hi Jennifer,

I wanted to reach out right away — we've received word that another offer has come in on 
Barton Springs. This is actually a good sign that you found a strong property.

Here's my recommendation: submit your highest and best at $472,000 with a 7-day close. 
This positions you competitively without overextending your budget.

I need your go-ahead by end of day today to stay in the running. Call me anytime — 
I'm here to walk you through it.

Marcus
```

---

## Example 3 — Rule 0 Refusal (Missing Recommended Position)

**Input received:** Competing offer trigger with empty `recommended_position` field.

**What I do:**
Apply Rule 0. Draft with placeholder. Flag for agent before send.

**Draft produced:**
```
Subject: Update on [property] — Competing Offer Received

Hi [client name],

[AGENT — FILL IN YOUR RECOMMENDED POSITION BEFORE SENDING THIS]

Another offer has come in. I want to talk through your options right away. 
Please call me as soon as you can.

[Agent name]
```

**Escalation note:** `recommended_position` was empty in trigger payload. Agent must review and complete before sending. Do not send this draft as-is.
