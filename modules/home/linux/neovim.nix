# File: neovim.nix
# Author: rowsred
# Date: 2026-04-29
# Descriptions:
{ inputs, ... }:
{
  flake.homeModules.neovim =
    { pkgs, ... }:
    let
      unstable = import inputs.nixpkgs-unstable {
        system = pkgs.stdenv.hostPlatform.system;
      };
    in
    {
      home.packages = [
        unstable.neovim
        unstable.wl-clipboard-rs
        unstable.tree-sitter
        unstable.nil
        unstable.clang
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
