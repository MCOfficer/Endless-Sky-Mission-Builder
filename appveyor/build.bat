REM Setup
set PLATFORM=win64
set PYTHON=C:\Python37-x64\python
IF %PROCESSOR_ARCHITECTURE% == x86 (
  IF NOT DEFINED PROCESSOR_ARCHITEW6432 (
    set PLATFORM=win32
    set PYTHON=C:\Python37\python
  )
)
echo Running on %PLATFORM%
%PYTHON% -m pip install nuitka pyinstaller

REM Nuitka Compilation
%PYTHON% -m nuitka --assume-yes-for-downloads --standalone --show-progress --show-scons --plugin-enable=tk-inter ESMB.py
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
