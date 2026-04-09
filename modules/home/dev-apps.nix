# File: devApps.nix
# Author: rowsred
# Date: 2026-04-08
# Description: just for hoby
{ ... }:
{
  flake.modules.homeManager.dev-apps =
    { pkgs, ... }:
    {

      home.packages = with pkgs; [
        fuzzel
        google-chrome
        btop
        ripgrep
        tree
        fd
        starship
        rustup
        fzf
        rsync
        unzip
        wget
        clang
        fastfetch
        nautilus
      ];

    };
}
