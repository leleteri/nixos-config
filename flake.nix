{
  description = "NixOS + Home Manager (multi-host, multi-user)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux"; # adjust if needed (aarch64-linux for ARM)
  in {
    nixosConfigurations = {
      # Build with: sudo nixos-rebuild switch --flake ~/nixos-config#${systemHost}
      $lele = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/$lele/configuration.nix

          # Home Manager as a NixOS module
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.lele = import ./home/lele/home.nix;
          }
        ];
      };
    };
  };
}
