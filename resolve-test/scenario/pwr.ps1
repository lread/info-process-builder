$env:PATH = "$PWD\on-path;$env:PATH"
cd cwd
echo '==== How does `a` resolve from cwd?'
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1
echo 'program: a'
a
echo ""
bb ..\..\scenario.clj set  --cwd=bat,cmd,exe,ps1
echo 'program: a'
a
echo ""
bb ..\..\scenario.clj set  --cwd=bat,cmd,ps1
echo 'program: a'
a
echo ""
bb ..\..\scenario.clj set  --cwd=cmd,ps1
echo 'program: a'
a
echo ""
bb ..\..\scenario.clj set  --cwd=ps1
echo 'program: a'
a
echo ""
echo '==== How does `a.<ext>` resolve from cwd?'
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1
echo 'program: a.ps1'
a.ps1
echo ""
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1
echo 'program: a.com'
a.com
echo ""
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1
echo 'program: a.exe'
a.exe
echo ""
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1
echo 'program: a.bat'
a.bat
echo ""
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1
echo 'program: a.cmd'
a.cmd
echo ""
echo '==== How does `a.<ext>` resolve from cwd when also on PATH?'
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo 'program: a.ps1'
a.ps1
echo ""
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo 'program: a.com'
a.com
echo ""
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo 'program: a.exe'
a.exe
echo ""
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo 'program: a.bat'
a.bat
echo ""
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo 'program: a.cmd'
a.cmd
echo ""
bb ..\..\scenario.clj set  --on-path=bat,cmd,com,exe,ps1
echo 'program: a.ps1'
a.ps1
echo ""
bb ..\..\scenario.clj set  --on-path=bat,cmd,com,exe,ps1
echo 'program: a.com'
a.com
echo ""
bb ..\..\scenario.clj set  --on-path=bat,cmd,com,exe,ps1
echo 'program: a.exe'
a.exe
echo ""
bb ..\..\scenario.clj set  --on-path=bat,cmd,com,exe,ps1
echo 'program: a.bat'
a.bat
echo ""
bb ..\..\scenario.clj set  --on-path=bat,cmd,com,exe,ps1
echo 'program: a.cmd'
a.cmd
echo ""
echo '==== How does `a` resolve from cwd when also on `PATH`?'
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo 'program: a'
a
echo ""
bb ..\..\scenario.clj set  --cwd=bat,cmd,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo 'program: a'
a
echo ""
bb ..\..\scenario.clj set  --cwd=bat,cmd,ps1 --on-path=bat,cmd,com,exe,ps1
echo 'program: a'
a
echo ""
bb ..\..\scenario.clj set  --cwd=cmd,ps1 --on-path=bat,cmd,com,exe,ps1
echo 'program: a'
a
echo ""
bb ..\..\scenario.clj set  --cwd=ps1 --on-path=bat,cmd,com,exe,ps1
echo 'program: a'
a
echo ""
bb ..\..\scenario.clj set  --cwd=ps1 --on-path=bat,cmd,com,exe
echo 'program: a'
a
echo ""
bb ..\..\scenario.clj set  --cwd=ps1 --on-path=bat,cmd,exe
echo 'program: a'
a
echo ""
bb ..\..\scenario.clj set  --cwd=ps1 --on-path=bat,cmd
echo 'program: a'
a
echo ""
bb ..\..\scenario.clj set  --cwd=ps1 --on-path=cmd
echo 'program: a'
a
echo ""
bb ..\..\scenario.clj set  --cwd=ps1
echo 'program: a'
a
echo ""
echo '==== How does `.\a` resolve from cwd?'
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1
echo 'program: .\a'
.\a
echo ""
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe
echo 'program: .\a'
.\a
echo ""
bb ..\..\scenario.clj set  --cwd=bat,cmd,exe
echo 'program: .\a'
.\a
echo ""
bb ..\..\scenario.clj set  --cwd=bat,cmd
echo 'program: .\a'
.\a
echo ""
bb ..\..\scenario.clj set  --cwd=cmd
echo 'program: .\a'
.\a
echo ""
echo '==== How does `.\a.<ext>` resolve from cwd?'
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1
echo 'program: .\a.ps1'
.\a.ps1
echo ""
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1
echo 'program: .\a.com'
.\a.com
echo ""
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1
echo 'program: .\a.exe'
.\a.exe
echo ""
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1
echo 'program: .\a.bat'
.\a.bat
echo ""
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1
echo 'program: .\a.cmd'
.\a.cmd
echo ""
echo '==== We expect absolute path of `a.<ext>` to work fine, do they?'
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo 'program: Z:\lread\info-process-builder\resolve-test\scenario\cwd\a.ps1'
Z:\lread\info-process-builder\resolve-test\scenario\cwd\a.ps1
echo ""
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo 'program: Z:\lread\info-process-builder\resolve-test\scenario\cwd\a.com'
Z:\lread\info-process-builder\resolve-test\scenario\cwd\a.com
echo ""
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo 'program: Z:\lread\info-process-builder\resolve-test\scenario\cwd\a.exe'
Z:\lread\info-process-builder\resolve-test\scenario\cwd\a.exe
echo ""
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo 'program: Z:\lread\info-process-builder\resolve-test\scenario\cwd\a.bat'
Z:\lread\info-process-builder\resolve-test\scenario\cwd\a.bat
echo ""
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo 'program: Z:\lread\info-process-builder\resolve-test\scenario\cwd\a.cmd'
Z:\lread\info-process-builder\resolve-test\scenario\cwd\a.cmd
echo ""
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo 'program: Z:\lread\info-process-builder\resolve-test\scenario\workdir\a.ps1'
Z:\lread\info-process-builder\resolve-test\scenario\workdir\a.ps1
echo ""
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo 'program: Z:\lread\info-process-builder\resolve-test\scenario\workdir\a.com'
Z:\lread\info-process-builder\resolve-test\scenario\workdir\a.com
echo ""
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo 'program: Z:\lread\info-process-builder\resolve-test\scenario\workdir\a.exe'
Z:\lread\info-process-builder\resolve-test\scenario\workdir\a.exe
echo ""
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo 'program: Z:\lread\info-process-builder\resolve-test\scenario\workdir\a.bat'
Z:\lread\info-process-builder\resolve-test\scenario\workdir\a.bat
echo ""
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo 'program: Z:\lread\info-process-builder\resolve-test\scenario\workdir\a.cmd'
Z:\lread\info-process-builder\resolve-test\scenario\workdir\a.cmd
echo ""
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo 'program: Z:\lread\info-process-builder\resolve-test\scenario\on-path\a.ps1'
Z:\lread\info-process-builder\resolve-test\scenario\on-path\a.ps1
echo ""
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo 'program: Z:\lread\info-process-builder\resolve-test\scenario\on-path\a.com'
Z:\lread\info-process-builder\resolve-test\scenario\on-path\a.com
echo ""
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo 'program: Z:\lread\info-process-builder\resolve-test\scenario\on-path\a.exe'
Z:\lread\info-process-builder\resolve-test\scenario\on-path\a.exe
echo ""
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo 'program: Z:\lread\info-process-builder\resolve-test\scenario\on-path\a.bat'
Z:\lread\info-process-builder\resolve-test\scenario\on-path\a.bat
echo ""
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo 'program: Z:\lread\info-process-builder\resolve-test\scenario\on-path\a.cmd'
Z:\lread\info-process-builder\resolve-test\scenario\on-path\a.cmd
echo ""
