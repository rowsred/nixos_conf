# File: linux-root.nix
# Author: rowsred
# Date: 2026-04-29
# Descriptions:
{ config, ... }:
{

  configurations.home.dev.module = {
    imports = [
      config.flake.homeModules.neovim
      config.flake.homeModules.dotfiles-manager
      config.flake.homeModules.git
      {
        home = {
          username = "dev";
          homeDirectory = "/home/dev";
          stateVersion = "25.11";
        };
      }
    ];
  };
}
