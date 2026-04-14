# File: network.nix
# Author: rowsred
# Date: 2026-04-11
# Description: just for hoby
{ ... }:
{
  flake.modules.nixos.network =
    { ... }:
    {
      networking.networkmanager.enable = true;
    };
}
