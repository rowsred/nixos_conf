# File: apps.nix
# Author: rowsred
# Date: 2026-04-08
# Description: just for hoby

{ inputs, ... }:
let
  unstable = import inputs.nixpkgs-unstable {

  };
in
{
  flake.modules.homeManager.nvim =
    { pkgs, ... }:
    {
      home.packages = [
        inputs.neovim-nightly-overlay.packages.${pkgs.system}.default
        unstable.wl-clipboard-rs
        unstable.nil
        pkgs.nixfmt
        pkgs.slint-lsp
        pkgs.clang-tools
        pkgs.stylua
        pkgs.prettier
        pkgs.lua-language-server
        pkgs.nerd-fonts.symbols-only

      ];
    };
}
