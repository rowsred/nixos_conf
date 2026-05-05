# File: linux-root.nix
# Author: rowsred
# Date: 2026-04-29
# Descriptions:
{ config, ... }:
{

  configurations.home.row.module = {
    imports = [
      config.flake.homeModules.programs-manager
      #  config.flake.homeModules.shell-manager
      config.flake.homeModules.pkgs
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
