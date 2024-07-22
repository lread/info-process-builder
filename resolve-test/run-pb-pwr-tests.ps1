# Run from a CMD shell once under against jdk version you'd like to test

$java_version = clojure -M java-version.clj
echo "Test jdk ${java_version}"
javac PBResolveTest.java
if (-Not (Test-Path -Path results)) {
    New-Item -ItemType Directory -Path results
}
cd scenario
./pb-pwr.ps1 *> "../results/pb-pwr-jdk-${java_version}-res.out"
