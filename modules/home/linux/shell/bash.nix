# File: bash.nix
# Author: rowsred
# Date: 2026-05-04
# Descriptions:

{ ... }:
{
  flake.homeModules.bash =
    { pkgs, ... }:
    {
      programs.bash = {
        enable = true;
        enableCompletion = true;
      };
      home.packages = with pkgs; [
        fastfetch
        just
      ];
    };
}
