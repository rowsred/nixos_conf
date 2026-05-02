# File: flake.nix
# Author: rowsred
# Date: 2026-04-08
# Description: just for hoby

{
  description = "Description for the project";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    kwm.url = "github:rowsred/river_kwm_modules_nixos";
    import-tree.url = "github:vic/import-tree";
    home-manager.url = "github:nix-community/home-manager";
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);

}
