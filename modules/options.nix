# File: options.nix
# Author: rowsred
# Date: 2026-04-10
# Description: just for hoby

{
  inputs,
  lib,
  config,
  ...
}:
{
  options.configurations.home = lib.mkOption {
    type = lib.types.lazyAttrsOf (
      lib.types.submodule {
        options.module = lib.mkOption {
          type = lib.types.deferredModule;
        };
      }
    );
  };

  config.flake.homeConfigurations = lib.flip lib.mapAttrs config.configurations.home (
    name:
    { module }:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import inputs.nixpkgs-unstable {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
      modules = [ module ];
    }
  );
}
