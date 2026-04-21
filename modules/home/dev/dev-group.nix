# File: dev-group.nix
# Author: rowsred
# Date: 2026-04-14
# Description: just for hoby
{ config, ... }:
{
  flake.modules.homeManager.dev-group = {
    imports = [
      config.flake.modules.homeManager.git-settings
      config.flake.modules.homeManager.shell-settings
      config.flake.modules.homeManager.zellij
    ];
  };
}
