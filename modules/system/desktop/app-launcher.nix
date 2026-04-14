# File: apps-launcher.nix
# Author: rowsred
# Date: 2026-04-11
# Description: just for hoby
{ ... }:
{
  flake.modules.nixos.app-launcher =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        fuzzel
      ];
    };
}
