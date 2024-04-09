# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ pkgs, inputs, ... }:

{
  imports = [
    # include NixOS-WSL modules
    <nixos-wsl/modules>
  ];

  wsl.enable = true;
  wsl.defaultUser = "nixos";

  nix = {
    settings = {
      # Enable Flakes and the new command-line tool
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "nixos" ];
      sandbox = "relaxed";
      allowed-uris = [
        "https://"
        "github:NixOS/"
        "github:nixos/"
        "github:hercules-ci/"
        "github:numtide/"
        "github:cachix/"
        "github:nix-community/"
        "github:nix-systems/"
      ];

    };
    package = pkgs.nixVersions.nix_2_19;
    # NOTE: pin nix's nixpkgs to the exact version of nixpkgs used to build this config
    registry.nixpkgs.flake = inputs.nixpkgs;
  };

  virtualisation = { docker.enable = true; };

  programs.fish.enable = true;
  users.users.nixos.shell = pkgs.fish;
  environment.systemPackages = with pkgs; [ git vim ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
