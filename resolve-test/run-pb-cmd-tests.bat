REM Run from a CMD shell once under against jdk version you'd like to test

for /f "delims=" %%i in ('clojure -M java-version.clj') do set "JAVA_VERSION=%%i"
echo Test jdk %JAVA_VERSION%
javac PBResolveTest.java
mkdir results
cd scenario
pb-cmd.bat > ../results/pb-cmd-jdk-%JAVA_VERSION%-res.out 2>&1
