REM Dependencies
C:\Python37-x64\python -m pip install nuitka pyinstaller

REM Nuitka Compilation
C:\Python37-x64\python -m nuitka --assume-yes-for-downloads --standalone --show-progress --show-scons --plugin-enable=tk-inter --output-dir ESMB ESMB.py
7z a -tzip -mx9 -y ESMB-win64-nuitka.zip .\ESMB\

REM PyInstaller
C:\Python37-x64\Scripts\pyinstaller -D -y -w ESMB.py
7z a -tzip -mx9 -y ESMB-win64-pyinstaller.zip .\dist\ESMB

C:\Python37-x64\Scripts\pyinstaller -F -y -w ESMB.py --dispath onefile.dist
cp onefile.dist\ESMB ESMB-win64-pyinstaller.exe
