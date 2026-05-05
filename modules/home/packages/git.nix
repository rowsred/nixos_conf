# File: git.nix
# Author: rowsred
# Date: 2026-04-30
# Descriptions:
{ ... }:
{
  flake.homeModules.git = {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "rowsred";
          email = "fadlidev99@gmail.com";

        };

      };

    };

  };
}
