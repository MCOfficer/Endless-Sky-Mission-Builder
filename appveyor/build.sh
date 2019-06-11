# Dependencies
pip3 install nuitka pyinstaller

# Nuitka Compilation
python3 -m nuitka --assume-yes-for-downloads --standalone --show-progress --show-scons --plugin-enable=tk-inter ESMB.py
mv ESMB.dist ESMB
tar -czvf ESMB-amd64-nuitka.zip ESMB/

# PyInstaller
pyinstaller -D -y -w ESMB.py
tar -czvf ESMB-amd64-pyinstaller.zip dist/ESMB/

pyinstaller -F -y -w ESMB.py --distpath onefile.dist
cp onefile.dist/ESMB ESMB-amd64-pyinstaller
