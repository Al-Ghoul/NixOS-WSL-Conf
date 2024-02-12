{
  description = "AlGhoul's WSL NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    devenv.url = "github:cachix/devenv";
  };

  outputs = { nixpkgs, home-manager, devenv, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = inputs;
          modules = [
            ./configuration.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useUserPackages = true;
              home-manager.users.nixos = { imports = [ ./home.nix ]; };
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
              deadnix.enable = true;
              nil.enable = true;
              nixfmt.enable = true;

              commitizen.enable = true;
              markdownlint.enable = true;
            };

            scripts.pre.exec = ''
              exec .git/hooks/pre-commit
            '';

          })
        ];

      };

    };
}
