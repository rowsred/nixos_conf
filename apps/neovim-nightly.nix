{ inputs, pkgs, ... }:
{
  environment.systemPackages = [
    inputs.neovim-nightly-overlay.packages.${pkgs.system}.default
    pkgs.tree-sitter
    pkgs.rust-analyzer
    pkgs.rustfmt
    pkgs.nixfmt
    pkgs.nixd
    pkgs.slint-lsp
    pkgs.stylua
    pkgs.prettier
  ];
}
