@echo off
SET THEFILE=serverimages.exe
echo Linking %THEFILE%
c:\lazarus\fpc\2.0.4\bin\i386-win32\ld.exe -b pe-i386 -m i386pe   --subsystem windows   -o serverimages.exe link.res
if errorlevel 1 goto linkend
c:\lazarus\fpc\2.0.4\bin\i386-win32\postw32.exe --subsystem gui --input serverimages.exe --stack 262144
if errorlevel 1 goto linkend
goto end
:asmend
echo An error occured while assembling %THEFILE%
goto end
:linkend
echo An error occured while linking %THEFILE%
:end
