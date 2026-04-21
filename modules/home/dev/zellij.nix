# File: zellij.nix
# Author: rowsred
# Date: 2026-04-21
# Description:
{ ... }:
{

  flake.modules.homeManager.zellij = {
    programs.zellij = {
      enable = true;
      enableBashIntegration = true;
      settings = {
        show_startup_tips = false;
        plugins = {
          welcome_screen = {
            enabled = false;
          };
        };
        keybinds = {
          locked = {
            "bind \"Alt h\"" = {
              MoveFocusOrTab = "Left";
            };
            "bind \"Alt l\"" = {
              MoveFocusOrTab = "Right";
            };
          };
        };
      };

    };

  };
}
