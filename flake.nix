{
  description = "NixOS (aarch64) for UTM on Apple Silicon with Hyprland + Home Manager + Disko (zero-touch install)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, disko, ... }:
  let
    system = "aarch64-linux";
    mkHost = hostName: nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        disko.nixosModules.disko
        ./hosts/${hostName}/configuration.nix
        home-manager.nixosModules.home-manager
      ];
      specialArgs = { inherit hostName; };
    };
  in {
    nixosConfigurations = {
      utm-m1 = mkHost "utm-m1";
    };
  };
}
