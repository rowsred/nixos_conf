# File: apps.nix
# Author: rowsred
# Date: 2026-04-08
# Description: just for hoby

{ inputs, ... }:
{
  flake.modules.homeManager.nvim =
    { pkgs, ... }:
    let
      unstable = import inputs.nixpkgs-unstable {
        system = pkgs.stdenv.hostPlatform.system;
      };
    in
    {
      home.packages = [
        inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default
        unstable.wl-clipboard-rs
        unstable.tree-sitter
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
