#!/usr/bin/zsh

ToolsDir=/opt/tools/
VirtualenvDir=${ToolsDir}/venv/

echo "============================================================="
echo "=== System monitoring ======================================="

sudo apt install glances htop -y -q

echo "============================================================="
echo "=== flameshot (screenshot) =================================="

sudo apt install flameshot -y -q

echo "============================================================="
echo "=== evince (pdf) ============================================"
sudo apt install evince -y -q

echo "============================================================="
echo "=== Chromium web browser ===================================="
sudo apt install chromium chromium-l10n -y -q

echo "============================================================="
echo "=== libraries for win/cross compile ========================="
sudo apt install -q -y libc6-dev-i386 mingw-w64
sudo dpkg --add-architecture i386 && sudo apt-get update && sudo apt-get install wine32 

echo "============================================================="
echo "=== FTP ====================================================="
sudo apt install atftp pure-ftpd -y -q

sudo groupadd ftpgroup
sudo useradd -g ftpgroup -d /dev/null -s /etc ftpuser
echo
echo "Please, set password to 'ftppasswd'"
sudo pure-pw useradd offsec -u ftpuser -d /ftphome
sudo pure-pw mkdb
#sudo cd /etc/pure-ftpd/auth/
#sudo ln -s ../conf/PureDB 60pdb
[ -e /etc/pure-ftpd/auth/60pdb] || sudo ln -s /etc/pure-ftpd/conf/PureDB /etc/pure-ftpd/auth/60pdb
[ -d /ftphome ] || sudo mkdir -p /ftphome
sudo chown -R ftpuser:ftpgroup /ftphome/


echo "============================================================="
echo "=== python virtualenv ======================================="
sudo apt install virtualenv -q -y

[ -e ${VirtualenvDir} ] || sudo rm -rf ${VirtualenvDir}
sudo bash -c "virtualenv -p python3 ${VirtualenvDir}"

echo "============================================================="
echo "=== install some tools from github =========================="

sudo bash -c ". ${VirtualenvDir}/bin/activate; python3 -m pip install git+https://github.com/Tib3rius/AutoRecon.git; deactivate"

#[ -d ${ToolsDir}/kerberoast ] && sudo rm -rf ${ToolsDir}/kerberoast
#sudo git clone https://github.com/nidem/kerberoast ${ToolsDir}/kerberoast
sudo apt install kerberoast -y -q

[ -d ${ToolsDir}/nmapautomator ] && sudo rm -rf ${ToolsDir}/nmapautomator
sudo git clone https://github.com/21y4d/nmapAutomator.git  ${ToolsDir}/nmapautomator
