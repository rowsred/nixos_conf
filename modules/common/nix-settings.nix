# File: settingsNix.nix
# Author: rowsred
# Date: 2026-04-08
# Description: just for hoby
{ inputs, ... }:
{
  flake.modules.nixos.nix-settings = {

    nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    nix.settings.trusted-users = [
      "root"
      "row"
    ];
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}
