REM Dependencies
C:\Python37-x64\python -m pip install nuitka pyinstaller

REM Nuitka Compilation
C:\Python37-x64\python -m nuitka --assume-yes-for-downloads --standalone --show-progress --show-scons --plugin-enable=tk-inter ESMB.py
7z a -tzip -mx9 -y artifacts\ESMB-win64-nuitka.zip .\ESMB.dist\*

REM PyInstaller
C:\Python37-x64\Scripts\pyinstaller -D -y -w ESMB.py
7z a -tzip -mx9 -y artifacts\ESMB-win64-pyinstaller.zip .\ESMB.dist\*
C:\Python37-x64\Scripts\pyinstaller -F -y -w ESMB.py
cp dist\ESMB.exe artifacts\ESMB-win64-pyinstaller.exe
