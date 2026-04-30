








{ inputs, ... }:
{
  flake.homeModules.dotfiles-manager = {
    xdg.configFile."nvim/init.lua".source = "${inputs.self}/src/config/nvim/init.lua";
  };
}
