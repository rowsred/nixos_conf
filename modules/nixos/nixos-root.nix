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
}
