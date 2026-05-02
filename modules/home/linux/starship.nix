# File: starship.nix
# Author: rowsred
# Date: 2026-04-30
# Descriptions:

{ ... }:
{
  flake.homeModules.starship = {

    programs.bash = {
      enable = true;
      enableCompletion = true;
      profileExtra = ''
        # Custom logic that usually goes in .profile
        if [ -d "$HOME/.local/bin" ] ; then
        PATH="$HOME/.local/bin:$PATH"
        fi

        if [ -z $XDG_RUNTIME_DIR ];then
        export XDG_RUNTIME_DIR=/tmp/user/$(id -u)
        mkdir -p $XDG_RUNTIME_DIR 
        chmod 700 $XDG_RUNTIME_DIR 
        fi
        alias ls=lsd

      '';
      bashrcExtra = ''
        # Extra interactive shell config
        export HISTSIZE=10000
      '';
    };

    programs.starship = {
      enable = true;
      enableBashIntegration = true; # Default is true
    };
  };
}
