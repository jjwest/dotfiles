# Install and configure i3wm
sudo echo "deb http://debian.sur5r.net/i3/ $(lsb_release -c -s) universe" >> /etc/apt/sources.list
sudo apt-get update
sudo apt-get --allow-unauthenticated install sur5r-keyring
sudo apt-get update
sudo apt-get install i3
cp -r i3/ ~/.config/

# Install and configure Emacs
sudo apt-get build-dept emacs24
curl -# "http://ftp.gnu.org/gnu/emacs/emacs-24.5.tar.gz"
tar -xvzf emacs-24.5.tar.gz
cd emacs-24.5
./configure
make
sudo make install
