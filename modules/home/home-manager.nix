# File: homeManager.nix
# Author: rowsred
# Date: 2026-04-08
# Description: just for hoby
{ inputs, ... }:
{
  imports = [
    inputs.home-manager.flakeModules.home-manager
    inputs.flake-parts.flakeModules.modules
  ];
}
