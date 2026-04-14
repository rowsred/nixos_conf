# File: core-group.nix
# Author: rowsred
# Date: 2026-04-14
# Description: just for hoby

{ config, ... }:
{
  flake.modules.nixos.core-group = {
    imports = [
      config.flake.modules.nixos.boot
      config.flake.modules.nixos.hardware-h61
      config.flake.modules.nixos.state-version
      config.flake.modules.nixos.users
      config.flake.modules.nixos.nix-group
    ];
  };
}
