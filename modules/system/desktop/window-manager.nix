# File: window-manager.nix
# Author: rowsred
# Date: 2026-04-11
# Description: just for hoby
{ inputs, ... }:
{
  flake.modules.nixos.window-manager =
    { ... }:
    {
      imports = [
        inputs.rill.nixosModules.default
      ];
    };
}
