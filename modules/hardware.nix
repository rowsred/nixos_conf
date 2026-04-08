# File: hardware.nix
# Author: rowsred
# Date: 2026-04-08
# Description: just for hoby
{ ... }:
{
  flake.nixosModules.hardware = {
    imports = [
      /etc/nixos/hardware-configuration.nix
    ];
  };
}
