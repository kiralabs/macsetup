#!/bin/bash
## gpgsetup.sh
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

if ! command -v gpg &> /dev/null
then
    echo "${red}GPG could not be found, did toolinstall.sh complete successfully?"
    echo "Aborting."
    exit
fi

# setup pinentry-program (gui)

brew install pinentry-mac
echo "pinentry-program $(which pinentry-mac)" >> ~/.gnupg/gpg-agent.conf
killall gpg-agent

# get gpg key location
echo "${yellow}[Status] Setting up GPG Key"
read -p 'Drag and Drop your GPG Private Key here: ' privgpg
echo "[Status] GPG Private Key is located in $privgpg ${reset}"

# import gpg key
echo "${cyan}[Status] Importing GPG Key"
echo "${pink}[Note] You may be prompted for a password to import the private key."
sleep 5 # message read time
echo "${pink}[Note] If you are hung here with no prompt, you might have entered no key, or an invalid one."
gpg --import $privgpg
echo "${green}[Done] Imported GPG Key! Now telling git about it"

# let git know about the signing key, and enable signing
echo "${yellow}[Status] All GPG Keys will be listed, please copy the Key ID from your GPG Key. (e.g: 3AA5C34371567BD2)"
gpg --list-secret-keys --keyid-format=long
read -p 'Paste or enter your GPG Key ID here: ' gpgid
git config --global user.signingkey $gpgid
echo "${green}[Done] Git GPG Signing key setup complete! - Now setting up git user info."

# set gpg key in zsh and bash
if [ -r ~/.zshrc ]; then echo 'export GPG_TTY=$(tty)' >> ~/.zshrc; \
  else echo 'export GPG_TTY=$(tty)' >> ~/.zprofile; fi

if [ -r ~/.bash_profile ]; then echo 'export GPG_TTY=$(tty)' >> ~/.bash_profile; \
  else echo 'export GPG_TTY=$(tty)' >> ~/.profile; fi

# git user info
echo "{$yellow}[Status] Setting up Git User Info"
read -p 'Paste or enter your Name here: ' gitname
read -p 'Paste or enter your Email here: ' gitemail
git config --global user.email "$gitemail"
git config --global user.name "$gitname"