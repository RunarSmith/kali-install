#!/usr/bin/zsh

# script directory
SCRIPT_DIR=`dirname ${BASH_SOURCE[0]-$0}`
SCRIPT_DIR=`cd $SCRIPT_DIR && pwd`

echo "============================================================="
echo "=== apt update =============================================="
sudo apt update
sudo apt full-upgrade --autoremove -y

# echo "meta packages available :"
# apt-cache search kali-linux
# default is : kali-linux-default
# If required :
# sudo apt install kali-linux-large -y -q

echo "============================================================="
echo "=== Let me speak Baguette !! ================================"

if [ "$LANG" != "fr_FR.UTF-8" ]; then
	echo "locale is FR"
else

	echo
	echo 1. Select locale "fr_FR.UTF-8"
	echo 2. Select default locale "fr_FR.UTF-8"
	echo
	echo "Press ENTER when ready"
	read

	sudo dpkg-reconfigure locales
fi

# default keayboard as FR, nice for lightdm greeter
CurrentX11Locale=$(localectl | grep 'X11 Layout' | cut -d ":" -f 2 )
if [ "${CurrentX11Locale}" = " fr" ]; then
	echo "X11 keymap already set to FR"
else
	echo "Setting X11 keymap to FR"
	sudo localectl set-x11-keymap fr
fi

CurrentTZ=$(timedatectl | grep "Time zone" | grep "Europe/Paris" )
if [ "$CurrentTZ" != "" ]; then
	echo "Timezone is Europe/Paris"
else
	echo
	echo Timezone: Select Europe/Paris
	echo
	echo "Press ENTER when ready"
	read

	sudo dpkg-reconfigure tzdata
fi

echo "============================================================="
echo "=== Uncompress RockYou ======================================"
if [ -f /usr/share/wordlists/rockyou.txt ]; then
	echo "/usr/share/wordlists/rockyou.txt already exists (uncompressed)"
elif [ -f /usr/share/wordlists/rockyou.txt.gz ]; then
	sudo gunzip /usr/share/wordlists/rockyou.txt.gz
else
	echo "WARN: /usr/share/wordlists/rockyou.txt.gz do not exists !!!!!!!"
fi

echo "============================================================="

${SCRIPT_DIR}/install-vscode.sh
${SCRIPT_DIR}/install-obsidian.sh
${SCRIPT_DIR}/install-tools.sh
${SCRIPT_DIR}/install-OSCP.sh

echo "============================================================="
echo "=== Updating locatedb ======================================="
sudo updatedb

echo "=== Done. ==================================================="
echo
echo "Don't forget to reboot if u have changed locale and/or timezone"
echo
echo
