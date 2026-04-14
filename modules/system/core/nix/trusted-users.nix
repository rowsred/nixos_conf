# File: trusted-users.nix
# Author: rowsred
# Date: 2026-04-12
# Description: just for hoby

{ ... }:
{
  flake.modules.nixos.trusted-users =
    { ... }:
    {
      nix.settings.trusted-users = [
        "root"
        "row"
      ];
    };
}
