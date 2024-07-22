@echo off
cd scenario
rmdir /S /Q on-path workdir cwd
mkdir on-path workdir cwd
set PATH=%CD%\on-path;%PATH%
copy deps.edn cwd
for /f "delims=" %%i in ('clojure -M java-version.clj') do set "JAVA_VERSION=%%i"
echo %JAVA_VERSION%
cd cwd
clojure -M ..\pb-resolve-test.clj > ..\results\cmd-%JAVA_VERSION%.out
