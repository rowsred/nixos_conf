# File: apps.nix
# Author: rowsred
# Date: 2026-04-08
# Description: just for hoby

{ ... }:
{
  flake.modules.nixos.system-apps =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        git
        vim
        gnumake
        kitty
      ];
    };
}
