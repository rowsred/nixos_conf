# File: default.nix
# Author: rowsred
# Date: 2026-04-08
# Description: just for hoby

{ self, inputs, ... }:
{
  flake.nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {

    specialArgs = { inherit inputs; };
    modules = [
      self.modules.nixos.boot
      self.modules.nixos.rill
      self.modules.nixos.hardware
      self.modules.nixos.nixos
      self.modules.nixos.users
      self.modules.nixos.ly
      self.modules.nixos.nix-settings
      self.modules.nixos.apps
      {
        nixpkgs.hostPlatform = "x86_64-linux";
      }
    ];
  };

  flake.homeConfigurations.row = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs-unstable {
      system = "x86_64-linux";
      config = {
        allowUnfree = true;
      };
    };
    modules = [
      self.modules.homeManager.nvim
      self.modules.homeManager.dev-apps
      {
        home = {
          username = "row";
          homeDirectory = "/home/row";
          stateVersion = "25.11";
        };
      }
    ];
  };
}
