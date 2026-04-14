# File: nixos-root.nix
# Author: rowsred
# Date: 2026-04-14
# Description: just for hoby

{
  inputs,
  config,
  ...
}:
let
  inherit (config.flake.modules) nixos;
  inherit (config.flake.modules) homeManager;
in
{
  imports = [
    inputs.flake-parts.flakeModules.modules
    inputs.home-manager.flakeModules.home-manager
  ];
  configurations.nixos.nixos.module = {
    imports = [
      nixos.system-root
      {
        nixpkgs.hostPlatform = "x86_64-linux";
      }
    ];
  };

  configurations.home.row.module = {
    imports = [
      homeManager.shell-settings
      homeManager.neovim
      homeManager.git-settings
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
