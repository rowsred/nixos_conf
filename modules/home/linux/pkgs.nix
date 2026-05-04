# File: pkgs.nix
# Author: rowsred
# Date: 2026-04-30
# Descriptions:
{ ... }:
{
  flake.homeModules.pkgs =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        brave
      ];
    };
}
