# Dependencies
python3 -m pip install nuitka pyinstaller

# Nuitka Compilation
python3 -m nuitka --assume-yes-for-downloads --standalone --show-progress --show-scons --plugin-enable=tk-inter ESMB.py
tar -czvf ESMB-amd64-nuitka.zip .\ESMB.dist\*

# PyInstaller
pyinstaller -D -y -w ESMB.py
tar -czvf ESMB-amd64-pyinstaller.zip .\ESMB.dist\*
pyinstaller -F -y -w ESMB.py
cp dist\ESMB ESMB-amd64-pyinstaller
