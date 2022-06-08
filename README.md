# macsetup
My set of scripts to setup macOS! - Made for Apple Silicon running macOS 12.0+!

## I am not responsible for any issues/problems using my scripts.

Currently, there is no automated full-setup.
However, in the scripts folder, the scripts do the following

### brewsetup.sh
Installs Homebrew from brew.sh if it isn't already installed and installs gpg, iterm and neofetch.

### gpgsetup.sh
Installs pinentry-mac, imports your Private GPG key, and sets it up for signing with Git, as well as sets up your Git Name and Email.

### sshsetup.sh
Imports your Public and Private SSH keys, and creates a config that will import the password to your keychain.

## To-Do
- Add TUI style "setup" - user can select what they want to run, etc.
- More Scripts
- Proper support for Intel Macs (low priority for me - also might just work without any issues already)
- Support for future dotfiles
- Setup and support OhmyZSH and plugins/theme.
