# File: default-browser.nix
# Author: rowsred
# Date: 2026-04-11
# Description: just for hoby
{ inputs, ... }:
{
  flake.modules.nixos.google-chrome =
    { pkgs, ... }:
    let
      unstable = import inputs.nixpkgs-unstable {
        system = pkgs.stdenv.hostPlatform.system;
        config = {
          allowUnfree = true;
        };
      };
    in
    {
      environment.systemPackages = [
        unstable.google-chrome
      ];
    };
}
