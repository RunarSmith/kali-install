#!/usr/bin/zsh

DownloadFolder=/tmp

echo "============================================================="
echo "=== pandoc/latex (OSCP report) =============================="
sudo apt install pandoc -y -q

[ -e /usr/share/pandoc/data/templates/eisvogel.latex ] && sudo rm -f /usr/share/pandoc/data/templates/eisvogel.latex
wget -q https://raw.githubusercontent.com/Wandmalfarbe/pandoc-latex-template/master/eisvogel.tex -O ${DownloadFolder}/eisvogel.tex
sudo mv ${DownloadFolder}/eisvogel.tex /usr/share/pandoc/data/templates/eisvogel.latex

sudo apt install texlive-base texlive-latex-base texlive-latex-recommended texlive-fonts-extra -y -q
