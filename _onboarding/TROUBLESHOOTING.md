# Troubleshooting Guide

Use this when something isn't working the way it should. Find your symptom, follow the steps.

---

## 1. A Lead Came In But Nothing Happened in GHL

**Symptom:** Someone called or filled out the form. No contact appeared in GHL. No pipeline stage was created.

**Steps:**
1. Check your GHL notifications — the contact may have been created but not assigned to you
2. Search GHL contacts by the lead's phone number or email
3. If the contact exists but has no pipeline stage — manually move them to "New Lead"
4. If the contact does not exist at all — create it manually, then add a note: "Manual entry — inbound channel missed"
5. Escalate to Diana if this happens more than once in a day (indicates a GHL voice bot or form configuration issue)

---

## 2. The Wrong Agent Was Assigned to a Lead

**Symptom:** A lead shows up in GHL assigned to the wrong agent — or unassigned entirely.

**Steps:**
1. Do NOT reassign mid-thread without Diana's approval
2. Add a note to the GHL contact: "Assignment appears incorrect — flagging for review"
3. Notify Diana directly (text or Slack)
4. Diana makes the reassignment call — agent ownership is a business decision, not a clerical fix

**Why this rule exists:** Every handoff in this system carries the assigned agent's name. Changing it mid-thread breaks the audit trail.

---

## 3. A Message Was Drafted But It Doesn't Sound Right

**Symptom:** 03_client_communication produced a draft but the tone feels off — too formal, too casual, or doesn't match the agent's voice.

**Steps:**
1. Do NOT send it as-is
2. Edit the draft directly — the agent always has final review before anything goes to a client
3. If the voice is consistently wrong for a specific agent, notify Diana — the agent's voice profile may need updating in the system

**Remember:** Every drafted message is a starting point, not a finished product. Agent review is required every time.

---

## 4. A Deal Deadline Was Missed

**Symptom:** An inspection, financing, or closing deadline passed without action.

**Steps:**
1. Open the deal in GHL immediately
2. Check the 04_transaction_coordinator notes — was the deadline flagged in advance?
3. If it was flagged and ignored: escalate to Diana now
4. If it was NOT flagged: add a note, notify Diana, and document what happened
5. Diana decides next steps — do not contact the other party's agent without her direction

**This is a Rule 0 situation.** Do not attempt to resolve a missed deadline without Diana.

---

## 5. A Client Is Upset and Wants to Speak to Someone Now

**Symptom:** Angry call, angry text, or a situation that needs a human immediately.

**Steps:**
1. Do not route this through the AI system
2. Notify the assigned agent directly (call or text — not GHL)
3. If the assigned agent is unavailable, contact Diana
4. Add a note to the GHL contact record: "Client requested immediate human contact — [date/time]"

**Rule:** No AI-drafted message goes to an upset client. Human response only.

---

## 6. The GHL Voice Bot Gave Wrong Information to a Caller

**Symptom:** A caller reports that the phone bot told them something incorrect (wrong agent name, wrong process, wrong timeline).

**Steps:**
1. Pull the call recording from GHL
2. Note exactly what was said incorrectly
3. Escalate to Diana with the recording timestamp
4. Diana decides whether to contact the caller with a correction

**Do not:** Tell the caller "our system made a mistake" without Diana's approval on the messaging.

---

## 7. You Don't Know Which Specialist to Use

**Symptom:** A request came in and you're not sure if it's a research request, a communication request, or something else.

**Steps:**
1. Check `COMMON_REQUESTS.md` first — it covers the 8 most common scenarios
2. If it's still unclear, default to routing through 00_orchestrator and describe the request plainly
3. If you're genuinely unsure and the request is time-sensitive — go to Diana directly

**Rule:** When in doubt, escalate. Never guess on routing for an active deal.

---

## 8. You Can't Find a File or Document for an Active Deal

**Symptom:** A client or title company is asking for a document and you can't locate it in GHL.

**Steps:**
1. Search GHL contact record for the client — all documents should be attached there
2. Check the deal notes in 04_transaction_coordinator for a document checklist
3. If the document was never uploaded: notify the assigned agent immediately
4. If the document exists but is in the wrong place: move it to the GHL contact record and add a note

---

## 9. Two Agents Are Both Working the Same Lead

**Symptom:** You discover two agents have both responded to the same lead independently.

**Steps:**
1. Stop all outreach immediately
2. Check GHL — who was the original assigned agent on the contact record?
3. The original assigned agent owns the lead — the second agent stands down
4. Notify Diana so she can address it with the team
5. Add a note to the contact: "Duplicate outreach occurred — resolved [date]"

---

## 10. Something Happened That Isn't in This Guide

**Steps:**
1. Stop. Do not improvise on an active deal.
2. Document exactly what happened in the GHL contact or deal notes
3. Go to Diana

**Diana's standing instruction:** "I would rather you interrupt me ten times than make a judgment call on a live deal without me."

---

## Escalation Contacts

| Situation | Contact |
|---|---|
| Active deal emergency | Diana — call or text directly |
| Agent conflict or assignment issue | Diana |
| GHL technical issue | Diana → she contacts GHL support |
| Anything requiring a judgment call | Diana |
