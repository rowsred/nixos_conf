# File: nixos.nix
# Author: rowsred
# Date: 2026-04-08
# Description: just for hoby
{ ... }:
{
  flake.modules.nixos.nixos = {
    networking.networkmanager.enable = true;
    environment.etc."gtk-3.0/settings.ini".text = ''
      [Settings]
      gtk-application-prefer-dark-theme = 1
    '';
    system.stateVersion = "25.11"; # Did you read the comment?
  };
}
