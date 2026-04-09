# File: hardware.nix
# Author: rowsred
# Date: 2026-04-08
# Description: just for hoby
{ ... }:
{
  flake.modules.nixos.hardware = {
    imports = [
      /etc/nixos/hardware-configuration.nix
    ];
  };
}
