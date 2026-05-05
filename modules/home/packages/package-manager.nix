# File: package-manager.nix
# Author: rowsred
# Date: 2026-05-05
# Descriptions: 
{config,...}:{
        flake.homeModules.package-manager = {
            imports = [
            config.flake.homeModules.neovim
            config.flake.homeModules.git
            config.flake.homeModules.vscode
];
            };
    }


