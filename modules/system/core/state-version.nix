# File: state-version.nix
# Author: rowsred
# Date: 2026-04-11
# Description: just for hoby
{ ... }:
{
  flake.modules.nixos.state-version =
    { ... }:
    {
      system.stateVersion = "25.11"; # Did you read the comment?
    };
}
