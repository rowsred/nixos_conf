# File: boot.nix
# Author: rowsred
# Date: 2026-04-08
# Description: just for hoby
{ ... }:
{

  flake.modules.nixos.boot =
    { pkgs, ... }:
    {

      boot.kernelParams = [ "video=1366x768@60" ];
      boot.loader.grub.enable = true;
      boot.loader.grub.efiSupport = true;
      boot.loader.efi.efiSysMountPoint = "/boot/efi";
      boot.loader.grub.device = "nodev"; # or "nodev" for efi only
      boot.kernelPackages = pkgs.linuxPackages_latest;
    };
}
