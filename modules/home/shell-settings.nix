# File: shell-settings.nix
# Author: rowsred
# Date: 2026-04-09
# Description: just for hoby
{ ... }:
{
  flake.modules.homeManager.shell-settings =
    { pkgs, ... }:
    {
      programs.starship = {
        enable = true;
        enableBashIntegration = true;
      };
      home.sessionVariables = {
        LANG = "en_US.UTF-8";
        LC_ALL = "en_US.UTF-8";
      };
      home.packages = [
        pkgs.fastfetch

      ];
      programs.bash = {
        enable = true;
        sessionVariables = {
          PATH = "$HOME/.local/bin:$HOME/.cargo/bin:$PATH";
        };
        shellAliases = {
          ls = "ls --color=auto";
        };
        initExtra = ''
          fastfetch
          # Auto-launch Tmux (uncomment jika ingin diaktifkan)
          # if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
          #   tmux attach-session -t home 2>/dev/null || tmux new-session -s home
          # fi
        '';
      };
    };

}
