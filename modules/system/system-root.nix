# File: system-root.nix
# Author: rowsred
# Date: 2026-04-14
# Description: just for hoby

{ config, ... }:
let
  inherit (config.flake.modules) nixos;
in
{
  configurations.nixos.nixos.module = {
    imports = [
      nixos.system-root
      {
        nixpkgs.hostPlatform = "x86_64-linux";
      }
    ];
  };
  flake.modules.nixos.system-root = {
    imports = [
      config.flake.modules.nixos.core-group
      config.flake.modules.nixos.desktop-group
      config.flake.modules.nixos.services-group
    ];
  };
}
