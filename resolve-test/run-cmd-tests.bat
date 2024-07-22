REM Run from a CMD shell once after tests are generated

mkdir results
cd scenario
cmd.bat > ../results/cmd-res.out 2>&1
