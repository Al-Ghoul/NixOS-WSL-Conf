{ ... }: {
  imports = [
    ./modules/home-manager/packages.nix
    ./modules/home-manager/direnv.nix
    ./modules/home-manager/shell.nix
    ./modules/home-manager/git.nix
    ./modules/home-manager/starship.nix
    ./modules/home-manager/neovim.nix
  ];
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
