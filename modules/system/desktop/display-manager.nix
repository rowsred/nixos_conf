# File: display-manager.nix
# Author: rowsred
# Date: 2026-04-11
# Description: just for hoby
{ ... }:
{
  flake.modules.nixos.display-manager =
    { inputs, ... }:
    {
      services.displayManager.ly.enable = true;
    };
}
