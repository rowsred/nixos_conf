# File: dotfiles-manager.nix
# Author: rowsred
# Date: 2026-04-19
# Description:
{ inputs, ... }:
{
  flake.modules.homeManager.dotfiles-manager = {
    xdg.configFile."nvim/init.lua".source = "${inputs.self}/src/config/nvim/init.lua";
    xdg.configFile."kwm/config.zon".source = "${inputs.self}/src/config/kwm/config.zon";
    xdg.configFile."kitty/kitty.conf".source = "${inputs.self}/src/config/kitty/kitty.conf";
    xdg.configFile."foot/foot.ini".source = "${inputs.self}/src/config/foot/foot.ini";
  };
}
