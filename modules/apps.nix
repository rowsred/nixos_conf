# File: apps.nix
# Author: rowsred
# Date: 2026-04-08
# Description: just for hoby

{ inputs, pkgs, ... }:
let
  unstable = import inputs.nixpkgs-unstable {
    config = {
      allowUnfree = true;
    };

  };
in
{
  flake.nixosModules.apps =
    { pkgs, ... }:
    {

      environment.systemPackages = with pkgs; [
        unstable.google-chrome
        unstable.vscodium
        unstable.kitty
        unstable.fuzzel
        btop
        ripgrep
        tree
        git
        vim
        fd
        rustup
        gnumake
        fzf
        rsync
        unzip
        wget
        starship
        clang
        fastfetch
        nautilus
      ];
    };
}
