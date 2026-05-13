# ============================================================
# AGENCY SYSTEM — Day 1 Scaffold Script
# Run this in PowerShell from wherever you want the project
# ============================================================

# STEP 1: Clone the repo you just created on GitHub
# Replace YOUR_GITHUB_USERNAME with your actual username
git clone https://github.com/awjames6875/agency-system.git
cd agency-system

# STEP 2: Create the 5 required specialist folders
New-Item -ItemType Directory -Name "00_orchestrator"
New-Item -ItemType Directory -Name "01_lead_qualifier"
New-Item -ItemType Directory -Name "02_property_research"
New-Item -ItemType Directory -Name "03_client_communication"
New-Item -ItemType Directory -Name "04_transaction_coordinator"

# STEP 3: Create the 3 extra folders (your differentiators)
New-Item -ItemType Directory -Name "_schemas"
New-Item -ItemType Directory -Name "_onboarding"
New-Item -ItemType Directory -Name "_examples"
New-Item -ItemType Directory -Name "_deployment"

# STEP 4: Create placeholder files in each specialist folder
# (You'll fill these in on Days 2-4 — just need the structure today)
$folders = @("00_orchestrator", "01_lead_qualifier", "02_property_research", "03_client_communication", "04_transaction_coordinator")
$files = @("identity.md", "rules.md", "examples.md", "handoff.md")

foreach ($folder in $folders) {
    foreach ($file in $files) {
        New-Item -ItemType File -Path "$folder\$file" | Out-Null
        Add-Content -Path "$folder\$file" -Value "# TODO: $file for $folder — Day 2-4 build"
    }
}

# STEP 5: Create placeholder files in extra folders
New-Item -ItemType File -Path "_onboarding\DAY_ONE.md" | Out-Null
Add-Content -Path "_onboarding\DAY_ONE.md" -Value "# TODO: Day-one onboarding pack — Day 4 build"

New-Item -ItemType File -Path "_onboarding\COMMON_REQUESTS.md" | Out-Null
Add-Content -Path "_onboarding\COMMON_REQUESTS.md" -Value "# TODO: Common requests guide — Day 4 build"

New-Item -ItemType File -Path "_onboarding\TROUBLESHOOTING.md" | Out-Null
Add-Content -Path "_onboarding\TROUBLESHOOTING.md" -Value "# TODO: Troubleshooting guide — Day 4 build"

New-Item -ItemType File -Path "_examples\full_buyer_journey.md" | Out-Null
Add-Content -Path "_examples\full_buyer_journey.md" -Value "# TODO: Full buyer journey walkthrough — Day 4 build"

New-Item -ItemType File -Path "_examples\full_seller_journey.md" | Out-Null
Add-Content -Path "_examples\full_seller_journey.md" -Value "# TODO: Full seller journey walkthrough (v2 stub) — Day 4 build"

New-Item -ItemType File -Path "_deployment\ghl_setup.md" | Out-Null
Add-Content -Path "_deployment\ghl_setup.md" -Value "# TODO: GHL funnel + workflow + pipeline setup — Day 3 build"

New-Item -ItemType File -Path "_deployment\ghl voice bot_config.md" | Out-Null
Add-Content -Path "_deployment\ghl voice bot_config.md" -Value "# TODO: GHL voice bot config + GHL integration — Day 3 build"

# STEP 6: Create .gitignore
@'
.env
.env.local
node_modules/
__pycache__/
*.pyc
.DS_Store
*.log
'@ | Set-Content .gitignore

# STEP 7: First commit
git add .
git commit -m "Day 1: Scaffold — folder structure, schemas, CLAUDE.md"
git push origin main

# STEP 8: Verify
Write-Host ""
tree /F
Write-Host ""
Write-Host "You'll know Day 1 scaffold is done when:" -ForegroundColor Green
Write-Host "  1. The tree above shows 5 specialist folders + 4 extra folders"
Write-Host "  2. Each specialist folder has 4 placeholder .md files"
Write-Host "  3. _schemas/ has 10 JSON files"
Write-Host "  4. CLAUDE.md exists at root"
Write-Host "  5. git log shows the Day 1 commit"
Write-Host "  6. GitHub repo shows the same structure when you refresh it"
