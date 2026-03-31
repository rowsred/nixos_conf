{ inputs, pkgs, ... }:
let
  unstable = import inputs.nixpkgs-unstable {

  };
in
{
  environment.systemPackages = [
    inputs.neovim-nightly-overlay.packages.${pkgs.system}.default
    unstable.rust-analyzer
    unstable.nil
    pkgs.tree-sitter
    pkgs.clippy
    pkgs.rustfmt
    pkgs.nixfmt
    pkgs.slint-lsp
    pkgs.stylua
    pkgs.prettier
    pkgs.lua-language-server
    pkgs.nerd-fonts.symbols-only

  ];
}
