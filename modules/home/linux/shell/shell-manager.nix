# File: shell-manager.nix
# Author: rowsred
# Date: 2026-05-04
# Descriptions:

{ config, ... }:
{
  flake.homeModules.shell-manager = {
    imports = [
      config.flake.homeModules.bash
      config.flake.homeModules.starship
    ];
  };
}
