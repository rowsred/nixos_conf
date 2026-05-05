# File: home-manager.nix
# Author: rowsred
# Date: 2026-05-05
# Descriptions: 
{config,...}:{
  configurations.home.row.module = {
    imports = [
      config.flake.homeModules.package-manager
      {
        home = {
          username = "row";
          homeDirectory = "/home/row";
          stateVersion = "25.11";
        };
      }
    ];
  };

}
