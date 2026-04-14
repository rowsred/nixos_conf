# File: browser-group.nix
# Author: rowsred
# Date: 2026-04-14
# Description: just for hoby

{ config, ... }:
{
  flake.modules.nixos.browser-group = {
    imports = [
      config.flake.modules.nixos.google-chrome
    ];
  };
}
