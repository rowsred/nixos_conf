# File: system-root.nix
# Author: rowsred
# Date: 2026-04-14
# Description: just for hoby

{ config, ... }:
{
  flake.modules.nixos.system-root = {
    imports = [
      config.flake.modules.nixos.core-group
      config.flake.modules.nixos.desktop-group
      config.flake.modules.nixos.services-group
    ];
  };
}
