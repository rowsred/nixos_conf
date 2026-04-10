# File: kwm-wm.nix
# Author: rowsred
# Date: 2026-04-09
# Description: just for hoby

{ inputs, ... }:
{
  flake.modules.nixos.kwm = {
    imports = [
      inputs.kwm.nixosModules.default
    ];
  };
}
