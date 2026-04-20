# File: wayland-group.nix
# Author: rowsred
# Date: 2026-04-14
# Description: just for hoby
{ config, ... }:
{
  flake.modules.nixos.wayland-group = {
    imports = [
      config.flake.modules.nixos.kwm
      config.flake.modules.nixos.app-launcher
    ];
  };

}
