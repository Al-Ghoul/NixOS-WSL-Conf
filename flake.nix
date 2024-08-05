{
  description = "AlGhoul's WSL NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    devenv.url = "github:cachix/devenv";
  };

  nixConfig = {
    extra-trusted-public-keys =
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  outputs = { nixpkgs, home-manager, devenv, nixvim, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };

          modules = [
            ./configuration.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useUserPackages = true;
              home-manager.useGlobalPkgs = true;
              home-manager.users.nixos = {
                imports = [ ./home.nix nixvim.homeManagerModules.nixvim ];
              };
            }
          ];
        };
      };

      devShells."${system}".default = devenv.lib.mkShell {
        inherit inputs pkgs;

        modules = [
          ({ ... }: {

            packages = with pkgs; [ cz-cli yarn ];

            pre-commit.hooks = {
              commitizen.enable = true;
              markdownlint.enable = true;
            };

          })
        ];

      };

    };
}
