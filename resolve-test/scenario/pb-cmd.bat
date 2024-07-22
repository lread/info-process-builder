@echo off
set PATH=%CD%\on-path;%PATH%
cd cwd
echo ==== How does ^`a^` resolve from cwd?
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1
echo program: a
java -cp ..\.. PBResolveTest a
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,exe,ps1
echo program: a
java -cp ..\.. PBResolveTest a
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,ps1
echo program: a
java -cp ..\.. PBResolveTest a
echo:
bb ..\..\scenario.clj set  --cwd=cmd,ps1
echo program: a
java -cp ..\.. PBResolveTest a
echo:
bb ..\..\scenario.clj set  --cwd=ps1
echo program: a
java -cp ..\.. PBResolveTest a
echo:
echo ==== How does ^`a.^<ext^>^` resolve from cwd?
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1
echo program: a.ps1
java -cp ..\.. PBResolveTest a.ps1
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1
echo program: a.com
java -cp ..\.. PBResolveTest a.com
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1
echo program: a.exe
java -cp ..\.. PBResolveTest a.exe
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1
echo program: a.bat
java -cp ..\.. PBResolveTest a.bat
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1
echo program: a.cmd
java -cp ..\.. PBResolveTest a.cmd
echo:
echo ==== How does ^`a.^<ext^>^` resolve from cwd when also on PATH?
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: a.ps1
java -cp ..\.. PBResolveTest a.ps1
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: a.com
java -cp ..\.. PBResolveTest a.com
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: a.exe
java -cp ..\.. PBResolveTest a.exe
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: a.bat
java -cp ..\.. PBResolveTest a.bat
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: a.cmd
java -cp ..\.. PBResolveTest a.cmd
echo:
bb ..\..\scenario.clj set  --on-path=bat,cmd,com,exe,ps1
echo program: a.ps1
java -cp ..\.. PBResolveTest a.ps1
echo:
bb ..\..\scenario.clj set  --on-path=bat,cmd,com,exe,ps1
echo program: a.com
java -cp ..\.. PBResolveTest a.com
echo:
bb ..\..\scenario.clj set  --on-path=bat,cmd,com,exe,ps1
echo program: a.exe
java -cp ..\.. PBResolveTest a.exe
echo:
bb ..\..\scenario.clj set  --on-path=bat,cmd,com,exe,ps1
echo program: a.bat
java -cp ..\.. PBResolveTest a.bat
echo:
bb ..\..\scenario.clj set  --on-path=bat,cmd,com,exe,ps1
echo program: a.cmd
java -cp ..\.. PBResolveTest a.cmd
echo:
echo ==== How does ^`a^` resolve from cwd when also on ^`PATH^`?
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: a
java -cp ..\.. PBResolveTest a
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: a
java -cp ..\.. PBResolveTest a
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: a
java -cp ..\.. PBResolveTest a
echo:
bb ..\..\scenario.clj set  --cwd=cmd,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: a
java -cp ..\.. PBResolveTest a
echo:
bb ..\..\scenario.clj set  --cwd=ps1 --on-path=bat,cmd,com,exe,ps1
echo program: a
java -cp ..\.. PBResolveTest a
echo:
bb ..\..\scenario.clj set  --cwd=ps1 --on-path=bat,cmd,com,exe
echo program: a
java -cp ..\.. PBResolveTest a
echo:
bb ..\..\scenario.clj set  --cwd=ps1 --on-path=bat,cmd,exe
echo program: a
java -cp ..\.. PBResolveTest a
echo:
bb ..\..\scenario.clj set  --cwd=ps1 --on-path=bat,cmd
echo program: a
java -cp ..\.. PBResolveTest a
echo:
bb ..\..\scenario.clj set  --cwd=ps1 --on-path=cmd
echo program: a
java -cp ..\.. PBResolveTest a
echo:
bb ..\..\scenario.clj set  --cwd=ps1
echo program: a
java -cp ..\.. PBResolveTest a
echo:
echo ==== How does ^`.\a^` resolve from cwd?
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1
echo program: .\a
java -cp ..\.. PBResolveTest .\a
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe
echo program: .\a
java -cp ..\.. PBResolveTest .\a
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,exe
echo program: .\a
java -cp ..\.. PBResolveTest .\a
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd
echo program: .\a
java -cp ..\.. PBResolveTest .\a
echo:
bb ..\..\scenario.clj set  --cwd=cmd
echo program: .\a
java -cp ..\.. PBResolveTest .\a
echo:
echo ==== How does ^`.\a.^<ext^>^` resolve from cwd?
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1
echo program: .\a.ps1
java -cp ..\.. PBResolveTest .\a.ps1
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1
echo program: .\a.com
java -cp ..\.. PBResolveTest .\a.com
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1
echo program: .\a.exe
java -cp ..\.. PBResolveTest .\a.exe
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1
echo program: .\a.bat
java -cp ..\.. PBResolveTest .\a.bat
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1
echo program: .\a.cmd
java -cp ..\.. PBResolveTest .\a.cmd
echo:
echo ==== We expect absolute path of ^`a.^<ext^>^` to work fine, do they?
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: Z:\lread\info-process-builder\resolve-test\scenario\cwd\a.ps1
java -cp ..\.. PBResolveTest Z:\lread\info-process-builder\resolve-test\scenario\cwd\a.ps1
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: Z:\lread\info-process-builder\resolve-test\scenario\cwd\a.com
java -cp ..\.. PBResolveTest Z:\lread\info-process-builder\resolve-test\scenario\cwd\a.com
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: Z:\lread\info-process-builder\resolve-test\scenario\cwd\a.exe
java -cp ..\.. PBResolveTest Z:\lread\info-process-builder\resolve-test\scenario\cwd\a.exe
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: Z:\lread\info-process-builder\resolve-test\scenario\cwd\a.bat
java -cp ..\.. PBResolveTest Z:\lread\info-process-builder\resolve-test\scenario\cwd\a.bat
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: Z:\lread\info-process-builder\resolve-test\scenario\cwd\a.cmd
java -cp ..\.. PBResolveTest Z:\lread\info-process-builder\resolve-test\scenario\cwd\a.cmd
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: Z:\lread\info-process-builder\resolve-test\scenario\workdir\a.ps1
java -cp ..\.. PBResolveTest Z:\lread\info-process-builder\resolve-test\scenario\workdir\a.ps1
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: Z:\lread\info-process-builder\resolve-test\scenario\workdir\a.com
java -cp ..\.. PBResolveTest Z:\lread\info-process-builder\resolve-test\scenario\workdir\a.com
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: Z:\lread\info-process-builder\resolve-test\scenario\workdir\a.exe
java -cp ..\.. PBResolveTest Z:\lread\info-process-builder\resolve-test\scenario\workdir\a.exe
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: Z:\lread\info-process-builder\resolve-test\scenario\workdir\a.bat
java -cp ..\.. PBResolveTest Z:\lread\info-process-builder\resolve-test\scenario\workdir\a.bat
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: Z:\lread\info-process-builder\resolve-test\scenario\workdir\a.cmd
java -cp ..\.. PBResolveTest Z:\lread\info-process-builder\resolve-test\scenario\workdir\a.cmd
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: Z:\lread\info-process-builder\resolve-test\scenario\on-path\a.ps1
java -cp ..\.. PBResolveTest Z:\lread\info-process-builder\resolve-test\scenario\on-path\a.ps1
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: Z:\lread\info-process-builder\resolve-test\scenario\on-path\a.com
java -cp ..\.. PBResolveTest Z:\lread\info-process-builder\resolve-test\scenario\on-path\a.com
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: Z:\lread\info-process-builder\resolve-test\scenario\on-path\a.exe
java -cp ..\.. PBResolveTest Z:\lread\info-process-builder\resolve-test\scenario\on-path\a.exe
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: Z:\lread\info-process-builder\resolve-test\scenario\on-path\a.bat
java -cp ..\.. PBResolveTest Z:\lread\info-process-builder\resolve-test\scenario\on-path\a.bat
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: Z:\lread\info-process-builder\resolve-test\scenario\on-path\a.cmd
java -cp ..\.. PBResolveTest Z:\lread\info-process-builder\resolve-test\scenario\on-path\a.cmd
echo:
echo ==== How does ^`a^` with workdir resolve from cwd, workdir, ^`PATH^`?
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: a
java -cp ..\.. PBResolveTest a ..\workdir
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: a
java -cp ..\.. PBResolveTest a ..\workdir
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,ps1
echo program: a
java -cp ..\.. PBResolveTest a ..\workdir
echo:
echo ==== How does ^`a.^<ext^>^` with workdir resolve from cwd, workdir, ^`PATH^`^`?
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: a.ps1
java -cp ..\.. PBResolveTest a.ps1 ..\workdir
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: a.ps1
java -cp ..\.. PBResolveTest a.ps1 ..\workdir
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: a.com
java -cp ..\.. PBResolveTest a.com ..\workdir
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,exe --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: a.com
java -cp ..\.. PBResolveTest a.com ..\workdir
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,exe --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: a.exe
java -cp ..\.. PBResolveTest a.exe ..\workdir
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: a.exe
java -cp ..\.. PBResolveTest a.exe ..\workdir
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: a.bat
java -cp ..\.. PBResolveTest a.bat ..\workdir
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd --workdir=cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: a.bat
java -cp ..\.. PBResolveTest a.bat ..\workdir
echo:
bb ..\..\scenario.clj set  --cwd=cmd --workdir=cmd --on-path=cmd
echo program: a.cmd
java -cp ..\.. PBResolveTest a.cmd ..\workdir
echo:
bb ..\..\scenario.clj set  --cwd=cmd --on-path=cmd
echo program: a.cmd
java -cp ..\.. PBResolveTest a.cmd ..\workdir
echo:
echo ==== How does ^`.\a^` with workdir resolve from cwd, workdir?
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: .\a
java -cp ..\.. PBResolveTest .\a ..\workdir
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: .\a
java -cp ..\.. PBResolveTest .\a ..\workdir
echo:
echo ==== How does ^`.\a.^<ext^>^` with workdir resolve from cwd, workdir?
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: .\a.ps1
java -cp ..\.. PBResolveTest .\a.ps1 ..\workdir
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: .\a.com
java -cp ..\.. PBResolveTest .\a.com ..\workdir
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: .\a.exe
java -cp ..\.. PBResolveTest .\a.exe ..\workdir
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: .\a.bat
java -cp ..\.. PBResolveTest .\a.bat ..\workdir
echo:
bb ..\..\scenario.clj set  --cwd=cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: .\a.bat
java -cp ..\.. PBResolveTest .\a.bat ..\workdir
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: .\a.cmd
java -cp ..\.. PBResolveTest .\a.cmd ..\workdir
echo:
bb ..\..\scenario.clj set  --cwd=bat,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: .\a.cmd
java -cp ..\.. PBResolveTest .\a.cmd ..\workdir
echo:
echo ==== We expect absolute path of ^`a.^<ext^>^` with workdir to work fine, do they?
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: Z:\lread\info-process-builder\resolve-test\scenario\cwd\a.ps1
java -cp ..\.. PBResolveTest Z:\lread\info-process-builder\resolve-test\scenario\cwd\a.ps1 ..\workdir
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: Z:\lread\info-process-builder\resolve-test\scenario\cwd\a.com
java -cp ..\.. PBResolveTest Z:\lread\info-process-builder\resolve-test\scenario\cwd\a.com ..\workdir
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: Z:\lread\info-process-builder\resolve-test\scenario\cwd\a.exe
java -cp ..\.. PBResolveTest Z:\lread\info-process-builder\resolve-test\scenario\cwd\a.exe ..\workdir
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: Z:\lread\info-process-builder\resolve-test\scenario\cwd\a.bat
java -cp ..\.. PBResolveTest Z:\lread\info-process-builder\resolve-test\scenario\cwd\a.bat ..\workdir
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: Z:\lread\info-process-builder\resolve-test\scenario\cwd\a.cmd
java -cp ..\.. PBResolveTest Z:\lread\info-process-builder\resolve-test\scenario\cwd\a.cmd ..\workdir
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: Z:\lread\info-process-builder\resolve-test\scenario\workdir\a.ps1
java -cp ..\.. PBResolveTest Z:\lread\info-process-builder\resolve-test\scenario\workdir\a.ps1 ..\workdir
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: Z:\lread\info-process-builder\resolve-test\scenario\workdir\a.com
java -cp ..\.. PBResolveTest Z:\lread\info-process-builder\resolve-test\scenario\workdir\a.com ..\workdir
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: Z:\lread\info-process-builder\resolve-test\scenario\workdir\a.exe
java -cp ..\.. PBResolveTest Z:\lread\info-process-builder\resolve-test\scenario\workdir\a.exe ..\workdir
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: Z:\lread\info-process-builder\resolve-test\scenario\workdir\a.bat
java -cp ..\.. PBResolveTest Z:\lread\info-process-builder\resolve-test\scenario\workdir\a.bat ..\workdir
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: Z:\lread\info-process-builder\resolve-test\scenario\workdir\a.cmd
java -cp ..\.. PBResolveTest Z:\lread\info-process-builder\resolve-test\scenario\workdir\a.cmd ..\workdir
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: Z:\lread\info-process-builder\resolve-test\scenario\on-path\a.ps1
java -cp ..\.. PBResolveTest Z:\lread\info-process-builder\resolve-test\scenario\on-path\a.ps1 ..\workdir
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: Z:\lread\info-process-builder\resolve-test\scenario\on-path\a.com
java -cp ..\.. PBResolveTest Z:\lread\info-process-builder\resolve-test\scenario\on-path\a.com ..\workdir
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: Z:\lread\info-process-builder\resolve-test\scenario\on-path\a.exe
java -cp ..\.. PBResolveTest Z:\lread\info-process-builder\resolve-test\scenario\on-path\a.exe ..\workdir
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: Z:\lread\info-process-builder\resolve-test\scenario\on-path\a.bat
java -cp ..\.. PBResolveTest Z:\lread\info-process-builder\resolve-test\scenario\on-path\a.bat ..\workdir
echo:
bb ..\..\scenario.clj set  --cwd=bat,cmd,com,exe,ps1 --workdir=bat,cmd,com,exe,ps1 --on-path=bat,cmd,com,exe,ps1
echo program: Z:\lread\info-process-builder\resolve-test\scenario\on-path\a.cmd
java -cp ..\.. PBResolveTest Z:\lread\info-process-builder\resolve-test\scenario\on-path\a.cmd ..\workdir
echo:
