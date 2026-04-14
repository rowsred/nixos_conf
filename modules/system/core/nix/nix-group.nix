# File: nix-group.nix
# Author: rowsred
# Date: 2026-04-14
# Description: just for hoby

{ config, ... }:
{
  flake.modules.nixos.nix-group = {
    imports = [
      config.flake.modules.nixos.features-flake
      config.flake.modules.nixos.trusted-users
    ];
  };
}
