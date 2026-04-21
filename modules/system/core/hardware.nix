# File: hardware.nix
# Author: rowsred
# Date: 2026-04-11
# Description: just for hoby
{ ... }:
{
  flake.modules.nixos.hardware-h61 =

    {
      config,
      lib,
      pkgs,
      modulesPath,
      ...
    }:

    {

      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      boot.initrd.availableKernelModules = [
        "ehci_pci"
        "ahci"
        "nvme"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ ];
      boot.extraModulePackages = [ ];

      fileSystems."/" = {
        device = "/dev/disk/by-uuid/938ecd32-6857-42b8-bc73-59dcfe411844";
        fsType = "f2fs";
      };

      fileSystems."/boot/efi" = {
        device = "/dev/disk/by-uuid/445E-7BE6";
        fsType = "vfat";
        options = [
          "fmask=0022"
          "dmask=0022"
        ];
      };

      swapDevices = [ ];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
}
