# Run from Powershell once after tests are generated

if (-Not (Test-Path -Path results)) {
    New-Item -ItemType Directory -Path results
}
cd scenario
.\pwr.ps1 *> ../results/pwr-res.out
