REM Setup
Set _os_bitness=64
IF %PROCESSOR_ARCHITECTURE% == x86 (
  IF NOT DEFINED PROCESSOR_ARCHITEW6432 Set _os_bitness=32
)
set PLATFORM=win%_os_bitness%
echo Running on %PLATFORM%
C:\Python37-x64\python -m pip install nuitka pyinstaller

REM Nuitka Compilation
C:\Python37-x64\python -m nuitka --assume-yes-for-downloads --standalone --show-progress --show-scons --plugin-enable=tk-inter ESMB.py
mv ESMB.dist ESMB
7z a -tzip -mx9 -y ESMB-%PLATFORM%-nuitka.zip .\ESMB\
rd /S /Q ESMB

REM PyInstaller
C:\Python37-x64\Scripts\pyinstaller -D -y -w ESMB.py
7z a -tzip -mx9 -y ESMB-%PLATFORM%-pyinstaller.zip .\dist\ESMB
rd /S /Q dist

C:\Python37-x64\Scripts\pyinstaller -F -y -w ESMB.py
cp dist\ESMB ESMB-%PLATFORM%-pyinstaller.exe
rd /S /Q dist
