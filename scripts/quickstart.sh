#!/usr/bin/env sh
# /qompassai/latex/scripts/quickstart.sh
# Qompass AI LaTeX Quickstart
# Copyright (C) 2025 Qompass AI
########################################
set -eu
print() { printf '[latexcv]: %s\n' "$1"; }
YEAR=$(date +'%Y')
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
LOCAL_PREFIX="${LOCAL_PREFIX:-$HOME/.local}"
TEXLIVE_ROOT="$LOCAL_PREFIX/texlive/$YEAR"
TEXMFVAR="$LOCAL_PREFIX/texlive/texmf-var"
TEXMFCONFIG="$XDG_CONFIG_HOME/texlive/texmf-config"
TEXMFHOME="$XDG_CONFIG_HOME/texmf"
BIN_PATH="$LOCAL_PREFIX/texlive/$YEAR/bin/x86_64-linux"
mkdir -p "$TEXLIVE_ROOT" "$TEXMFVAR" "$TEXMFCONFIG" "$TEXMFHOME" "$XDG_CONFIG_HOME/texlive"
BANNER() {
    printf '╭────────────────────────────────────────────╮\n'
    printf '│     Qompass AI · LaTeX Quick‑Start         │\n'
    printf '╰────────────────────────────────────────────╯\n'
    printf '    © 2025 Qompass AI. All rights reserved   \n\n'
}
PKGS="xifthen
ifmtarg
gillius
xkeyval
fontaxes
moresize
fontawesome
multirow
wrapfig
float
pgf
transparent
geometry
hyperref
enumitem
fancyhdr
tabularx
titlesec
textpos
xcolor
setspace
babel
biblatex
biber
csquotes
microtype
awesomebox
awesomecv
academicons
filecontents
lipsum
booktabs
etoolbox
inputenc
caption
subcaption
amsmath
amssymb
mathtools
amsfonts
physics
natbib
authblk
ulem
pdfpages
tikz-cd
pgfplots
minted
listings
pythontex
tcolorbox
algorithm2e
luacode
luatex85
xparse
expl3
gchords
"
profile_check() {
    PROFILE_PATH="$XDG_CONFIG_HOME/texlive/texlive.profile"
    if [ ! -f "$PROFILE_PATH" ]; then
        print "No profile file found at $PROFILE_PATH"
        print "Copy or create a TeX Live profile before running this script."
        exit 1
    fi
}
do_install() {
    print "Downloading TeX Live installer"
    cd /tmp || exit 1
    curl -fsSL -O http://ftp.fau.de/ctan/systems/texlive/tlnet/install-tl-unx.tar.gz
    print "Unpacking TeX Live installer"
    tar -xzf install-tl-unx.tar.gz
    rm install-tl-unx.tar.gz
    TL_DIR=$(find . -maxdepth 1 -type d -name 'install-tl-*' | head -n1 | sed 's|^\./||')
    if [ -z "$TL_DIR" ]; then
        print "Error: Installer directory not found."
        exit 1
    fi
    print "Preparing TeX Live installation in $LOCAL_PREFIX/texlive/$YEAR"
    cd "$TL_DIR" || exit 1
    chmod +x install-tl
    PROFILE_PATH="$XDG_CONFIG_HOME/texlive/texlive.profile"
    if [ ! -f "$PROFILE_PATH" ]; then
        print "No profile file found at $PROFILE_PATH"
        print "Copy or create a TeX Live profile before running this script."
        exit 1
    fi
    ./install-tl --no-interaction --profile="$PROFILE_PATH"
    print "TeX Live installation complete!"
}
add_texlive_to_path() {
    export PATH="$BIN_PATH:$PATH"
}
do_package_install() {
    add_texlive_to_path
    tlmgr_path="$BIN_PATH/tlmgr"
    if [ ! -x "$tlmgr_path" ]; then
        print "Error: tlmgr not found in $tlmgr_path"
        exit 1
    fi
    print "Installing recommended TeX Live packages for CVs, resumes, arXiv, and code listings..."
    echo "$PKGS" | xargs "$tlmgr_path" install --usermode
    print "All requested packages installed (user mode)."
}
do_show_version() {
    add_texlive_to_path
    print "Checking latex binary version:"
    if command -v pdflatex >/dev/null 2>&1; then
        pdflatex -v | head -n1
        print "TeX Live bin path: $BIN_PATH"
    else
        print "TeX Live not yet installed or not on PATH."
    fi
}
while :; do
    BANNER
    echo "What would you like to do?"
    echo " 1) Install/Upgrade TeX Live (user, rootless)"
    echo " 2) Install recommended CV/Resume/arXiv/code-listing packages"
    echo " 3) Show TeX Live version and bin path"
    echo " q) Quit"
    printf "Choose [1]: "
    read -r CHOICE
    [ -z "$CHOICE" ] && CHOICE=1
    case "$CHOICE" in
    1)
        profile_check
        do_install
        ;;
    2) do_package_install ;;
    3) do_show_version ;;
    q | Q)
        print "Goodbye!"
        exit 0
        ;;
    *) print "Invalid option." ;;
    esac
    echo
    printf "Press enter to return to menu..."
    read -r dummy
    clear
done
