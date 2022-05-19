#!/usr/bin/zsh

DownloadFolder="/tmp/"

echo "============================================================="
echo "=== Visual Studio Code ======================================"
if [ -f /usr/bin/code ];then
	echo "VS Code already installed"
else
	# Visual Studio Code
	wget -q "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" -O ${DownloadFolder}/vscode.deb
	sudo apt install ${DownloadFolder}/vscode.deb -y -q
	unlink ${DownloadFolder}/vscode.deb
fi

echo
echo "Version: "
code --version
echo
for ext in ms-vscode.powershell ms-ceintl.vscode-language-pack-fr silofy.hackthebox; do     
    echo "Installing VSCode Extension : $ext"
    code --install-extension $ext --force
    echo
done;
