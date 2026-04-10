# File: home-linux.nix
# Author: rowsred
# Date: 2026-04-10
# Description: just for hoby
{ inputs,... }:
{
  flake.modules.homeManager = {
    Shell =
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
          '';
        };
      };

    Git =
      { ... }:
      {
        programs.git = {
          enable = true;
          settings = {
            user = {
              name = "rowsred";
              email = "fadlidev99@gmail.com";
            };
          };
        };
      };

    Nvim =
      {  pkgs, ... }:
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
  };

}
