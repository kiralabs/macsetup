#!/bin/bash
## sshsetup.sh
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

# ask user for ssh keys
mkdir -p ~/.ssh/
echo "${yellow}[Status] Copying SSH keys"
echo "The directory you are copying your SSH keys from must not have any 
spaces in them. This may be fixed in the future."
read -p 'Drag and Drop your Private SSH Key here: ' privatekey
read -p 'Drag and Drop your Public SSH Key here: ' publickey
cp $privatekey ~/.ssh/key
cp $publickey ~/.ssh/key.pub
echo "Copying SSH Keys complete!${reset}"

# set ssh key variables
setpublickey=~/.ssh/key.pub
setprivatekey=~/.ssh/key

# start ssh agent
echo "${cyan}[setup] Starting SSH agent"
eval "$(ssh-agent -s)"

# setup ssh config in user folder
echo "[setup] Copying SSH config to ~/.ssh/config"
echo "Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/key" > ~/.ssh/config

# add ssh key to ssh-agent
echo "[setup] Adding SSH key to ssh-agent"
echo "${pink}[note] Using --apple-use-keychain only works in macOS 12.0 and later, assuming you are on this version.${reset}"
ssh-add --apple-use-keychain $setprivatekey

# done
echo "${green}SSH Key setup complete! - Re-open your terminal before 
continuing!${reset}"
