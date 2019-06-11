REM Dependencies
C:\Python37-x64\python -m pip install nuitka pyinstaller
curl -SsLo upx.zip https://github.com/upx/upx/releases/download/v3.95/upx-3.95-win64.zip
7z e .\upx.zip upx.exe -r

REM Prepare artifacts folder
md artifacts

REM Nuitka Compilation
C:\Python37-x64\python -m nuitka --assume-yes-for-downloads --standalone --show-progress --show-scons --plugin-enable=tk-inter ESMB.py
7z a -tzip -mx9 -y artifacts\ESMB-x86_64-nuitka.zip .\ESMB.dist\*

REM PyInstaller (No UPX)
C:\Python37-x64\Scripts\pyinstaller -D -y -w --noupx ESMB.py
7z a -tzip -mx9 -y artifacts\ESMB-x86_64-pyinstaller.zip .\ESMB.dist\*
C:\Python37-x64\Scripts\pyinstaller -F -y -w --noupx ESMB.py
cp dist\ESMB.exe artifacts\ESMB-x86_64-pyinstaller.exe

REM PyInstaller (UPX)
C:\Python37-x64\Scripts\pyinstaller -D -y -w ESMB.py
7z a -tzip -mx9 -y artifacts\ESMB-x86_64-pyinstaller-upx.zip .\ESMB.dist\*
C:\Python37-x64\Scripts\pyinstaller -F -y -w ESMB.py
cp dist\ESMB.exe artifacts\ESMB-x86_64-pyinstaller-upx.exe
