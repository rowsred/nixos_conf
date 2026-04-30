# File: imports.nix
# Author: rowsred
# Date: 2026-04-30
# Descriptions:
{
  inputs,
  ...
}:
{
  imports = [
    inputs.flake-parts.flakeModules.modules
    inputs.home-manager.flakeModules.home-manager
  ];
}
