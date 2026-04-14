# File: features-flake.nix
# Author: rowsred
# Date: 2026-04-12
# Description: just for hoby
{ ... }:
{
  flake.modules.nixos.features-flake =
    { ... }:
    {
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
}
