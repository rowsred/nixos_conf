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
      nixos-mods.rill
      #nixos-mods.kwm
      nixos-mods.nixos
      nixos-mods.users
      nixos-mods.ly
      nixos-mods.nix-settings
      nixos-mods.system-apps
      {
        nixpkgs.hostPlatform = "x86_64-linux";
      }
    ];
  };

  configurations.home.row.module = {
    imports = [
      home-mods.git-settings
      home-mods.dev-apps
      home-mods.shell-settings
      home-mods.nvim
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
