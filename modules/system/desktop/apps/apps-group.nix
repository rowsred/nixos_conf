# File: apps-group.nix
# Author: rowsred
# Date: 2026-04-14
# Description: just for hoby

{ config, ... }:

{
  flake.modules.nixos.apps-group = {
    imports = [

      config.flake.modules.nixos.system-apps
      config.flake.modules.nixos.browser-group
    ];

  };

}
