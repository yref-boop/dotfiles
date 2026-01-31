{

  description = "OS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";

    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixpkgs-unstable, niri, ... }@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      overlay-unstable = final: prev: {
        unstable = nixpkgs-unstable.legacyPackages.${prev.system};
      };
    in {
    nixosConfigurations = {
      desktop = lib.nixosSystem {
        inherit system;
        modules = [
          # overlays-module for "pkgs.unstable" availability
          ({ config, pkgs, ... }: { nixpkgs.overlays = [
              overlay-unstable
              niri.overlays.niri
            ];
          programs.niri.package = pkgs.niri-unstable;
          })
          niri.nixosModules.niri
          ./hosts/desktop/configuration.nix
        ];
      };
    };
    homeConfigurations = {
      iago = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          niri.homeModules.niri
          ./home.nix ];
      };
    };
  };

}
