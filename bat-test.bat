@echo off
set argc=0

echo "---foo---"
exe-test "%~1"
echo "---boo---"
for %%x in (%*) do Set /A argc+=1

echo argc: %argc%

Rem Try hard to avoid any extra escaping so do it the slow way
if %argC% GEQ 1 echo arg1: "%~1"
if %argC% GEQ 2 echo arg2: "%~2"
if %argC% GEQ 3 echo arg3: "%~3"
if %argC% GEQ 4 echo arg4: "%~4"
if %argC% GEQ 5 echo arg5: "%~5"
if %argC% GEQ 6 echo arg6: "%~6"
if %argC% GEQ 7 echo arg5: "%~7"
if %argC% GEQ 8 echo arg5: "%~8"
if %argC% GEQ 9 echo arg5: "%~9"
