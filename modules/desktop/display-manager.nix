# File: displayManager.nix
# Author: rowsred
# Date: 2026-04-08
# Description: just for hoby
{ ... }:
{
  flake.modules.nixos.ly = {
    services.displayManager.ly.enable = true;
  };
}
