# File: users.nix
# Author: rowsred
# Date: 2026-04-08
# Description: just for hoby
{ ... }:
{
  flake.modules.nixos.users = {

    users.users.row = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "adbusers"
        "kvm"
      ]; # Enable ‘sudo’ for the user.
    };
  };
}
