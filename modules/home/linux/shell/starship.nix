# File: starship.nix
# Author: rowsred
# Date: 2026-04-30
# Descriptions:

{ ... }:
{
  flake.homeModules.starship =
    { pkgs, ... }:
    {

      programs.starship = {
        enable = true;
        enableBashIntegration = true; # Default is true
      };
    };
}
