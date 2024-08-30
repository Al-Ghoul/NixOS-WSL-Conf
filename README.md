# NixOS-WSL

This [NixOS](https://nixos.org) configuration is for use with WSL and WSL2 on Windows.

## Installation

1. Follow the guide on the official (You'll need WSL2)
[NixOS-WSL](https://github.com/nix-community/NixOS-WSL?tab=readme-ov-file#quick-start)

2. Once you enter the WSL shell, run the following commands:

```bash
# git won't be installed automatically by default
nix-shell -p git

# Then clone the repo & cd there

# Backup your current configuration (default for fresh installations)
sudo mv /etc/nixos /etc/nixos.bak 

# Symlink the repo with the default nixos configuration location
sudo ln -s ~/repos/NixOS-WSL-Conf /etc/nixos

# Deploy the flake.nix located at the default location (/etc/nixos)
# which is just a sym link to ~/repos/NixOS-Conf
sudo nixos-rebuild switch --impure

```
