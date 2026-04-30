# File: dotfiles.nix
# Author: rowsred
# Date: 2026-04-30
# Descriptions:

{ inputs, ... }:
{
  flake.homeModules.dotfiles-manager = {
    xdg.configFile."nvim/init.lua".source = "${inputs.self}/src/config/nvim/init.lua";
  };
}
