{...}: {
  imports = [
    ./modules/home-manager/packages.nix
    ./modules/home-manager/direnv.nix
    ./modules/home-manager/shell.nix
    ./modules/home-manager/git.nix
    ./modules/home-manager/starship.nix
    ./modules/home-manager/nixvim.nix
  ];
  home = {
    username = "nixos";
    homeDirectory = "/home/nixos";
    stateVersion = "23.11";
  };
  programs.home-manager.enable = true;
}
