# Setup
PLATFORM=$(uname -i)
echo Running on $PLATFORM
sudo apt-get update && sudo apt-get -y install python3-pip
pip3 install nuitka pyinstaller

# Nuitka Compilation
python3 -m nuitka --assume-yes-for-downloads --standalone --show-progress --show-scons --plugin-enable=tk-inter ESMB.py
mv ESMB.dist ESMB
tar -czvf ESMB-ubuntu-$PLATFORM-nuitka.tar.gz ESMB/
rm -rf ESMB

# PyInstaller
pyinstaller -D -y -w ESMB.py
tar -czvf ESMB-ubuntu-$PLATFORM-pyinstaller.tar.gz dist/ESMB/
rm -rf dist

pyinstaller -F -y -w ESMB.py
cp dist/ESMB ESMB-ubuntu-$PLATFORM-pyinstaller
rm -rf dist
