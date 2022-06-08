#!/bin/bash
## brewsetup.sh
## Written by Izzy <3
## Created on 08-06-2022

# setup colors for status output
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
pink=`tput setaf 5`
cyan=`tput setaf 6`
white=`tput setaf 7`
reset=`tput sgr0`

# install brew unattended
if ! command -v brew &> /dev/null
then
    echo "${cyan}[Status] Installing Homebrew - sudo password required."
    NONINTERACTIVE=1
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
    echo "${green}[Done] Homebrew appears to be installed, installing tools in 5 seconds."
    sleep 5 clear
else
    echo "${pink}[Note] Homebrew already appears to be installed, skipping to installing tools in 5 seconds."
    sleep 5
    clear
fi

# install tools
echo "${cyan}[Status] Installing tools with homebrew"
echo "[Status] Installing gpg, iterm2, archey if not already installed."
command -v gpg >/dev/null 2>&1 || {gnupg=brew install gnupg}
command -v /Applications/iTerm.app/Contents/MacOS/iTerm2 >/dev/null 2>&1 || {iterm=brew install iterm2}
command -v archey >/dev/null 2>&1 || {archey=brew install archey}
$gnupg
$iterm
$archey
echo "${green}[Done] Homebrew and tool installation complete!${reset}"
