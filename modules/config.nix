# File: default.nix
# Author: rowsred
# Date: 2026-04-08
# Description: just for hoby

{
  self,
  inputs,
  ...
}:
let
  home-mods = self.modules.homeManager;
  nixos-mods = self.modules.nixos;

in
{
  flake.nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {

    specialArgs = { inherit inputs; };
    modules = [
      nixos-mods.hardware-h61
      nixos-mods.boot
      nixos-mods.users
      nixos-mods.nix-settings
      nixos-mods.nixos
      nixos-mods.ly
      nixos-mods.rill
      #nixos-mods.kwm
      nixos-mods.system-apps
      {
        nixpkgs.hostPlatform = "x86_64-linux";
      }
    ];
  };

  configurations.home.row.module = {
    imports = [
      home-mods.shell-settings
     # home-mods.dev-apps
      home-mods.nvim
      home-mods.git-settings
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
