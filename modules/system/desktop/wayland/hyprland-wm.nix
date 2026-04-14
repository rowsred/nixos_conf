# File: hyprland-wm.nix
# Author: rowsred
# Date: 2026-04-14
# Description: just for hoby
{ ... }:
{
  flake.modules.nixos.hyprland = {
    programs.hyprland.enable = true;
  };
}
