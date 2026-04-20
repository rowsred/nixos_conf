# File: kwm-wm.nix
# Author: rowsred
# Date: 2026-04-20
# Description:

{ inputs, ... }:
{

  flake.modules.nixos.kwm =
    { ... }:
    {
      imports = [
        inputs.kwm.nixosModules.default
      ];
    };

}
