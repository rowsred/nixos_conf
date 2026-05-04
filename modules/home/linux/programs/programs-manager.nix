# File: programs-manager.nix
# Author: rowsred
# Date: 2026-05-04
# Descriptions:
{ config, ... }:
{
  flake.homeModules.programs-manager = {
    imports = [
      config.flake.homeModules.git
      config.flake.homeModules.neovim
      config.flake.homeModules.vscode
    ];
  };

}
