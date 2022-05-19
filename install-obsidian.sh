#!/usr/bin/zsh

# obsidian markdown editor

DownloadFolder="/tmp/"

echo "============================================================="
echo "=== obsidian ================================================"

if [ -f /usr/bin/obsidian ]; then
	echo "Obsidian already installed : removing it before re-installing"
	sudo apt remove obsidian -y
fi

# search for the latest deb package available
latest=$(curl -s https://github.com/obsidianmd/obsidian-releases/releases | grep deb | grep -oE "\".*\.deb\"" | head -n 1 | tr -d '"')
echo $latest
wget -q "https://github.com/${latest}" -O ${DownloadFolder}/obsidian.deb

sudo apt install ${DownloadFolder}/obsidian.deb
