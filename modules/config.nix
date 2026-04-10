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
      nixos-mods.Hardware-h61
#      nixos-mods.Flake-parts
      nixos-mods.Boot
      nixos-mods.Users
      nixos-mods.Nix-settings
      nixos-mods.System-apps
      nixos-mods.State-version
      nixos-mods.Network
      nixos-mods.Window-manager
      nixos-mods.Display-manager
      nixos-mods.Apps-launcher
      nixos-mods.Default-browser
      {
        nixpkgs.hostPlatform = "x86_64-linux";
      }
    ];
  };

  configurations.home.row.module = {
    imports = [
      home-mods.Shell
      home-mods.Nvim
      home-mods.Git
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
