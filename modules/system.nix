# File: system.nix
# Author: rowsred
# Date: 2026-04-10
# Description: just for hoby
{ inputs,... }:
{
  #install flake-parts.modules
        imports = [
          inputs.flake-parts.flakeModules.modules
          inputs.home-manager.flakeModules.home-manager
        ];

  flake.modules.nixos = {

    Flake-parts =
      { inputs, ... }:
      {
        _module.args.flake-parts-lib = inputs.flake-parts.lib;
        imports = [
          inputs.flake-parts.flakeModules.modules
          inputs.home-manager.flakeModules.home-manager
        ];

      };

    Nix-settings =
      { inputs, ... }:
      {
        nix.settings.trusted-users = [
          "root"
          "row"
        ];
        nix.settings.experimental-features = [
          "nix-command"
          "flakes"
        ];
      };

    Hardware-h61 =

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
        boot.kernelModules = [ "kvm-intel" ];
        boot.extraModulePackages = [ ];

        fileSystems."/" = {
          device = "/dev/disk/by-uuid/91f618d6-c7f3-491a-9b28-1f92497cc943";
          fsType = "ext4";
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
    Boot =
      { pkgs, ... }:
      {

        boot.kernelParams = [ "video=1366x768@60" ];
        boot.loader.grub.enable = true;
        boot.loader.grub.efiSupport = true;
        boot.loader.efi.efiSysMountPoint = "/boot/efi";
        boot.loader.grub.device = "nodev"; # or "nodev" for efi only
        boot.kernelPackages = pkgs.linuxPackages_latest;

      };

    Users =
      { ... }:
      {
        users.users.row = {
          isNormalUser = true;
          extraGroups = [
            "wheel"
            "adbusers"
            "kvm"
          ]; # Enable ‘sudo’ for the user.
        };
      };

    Network =
      { ... }:
      {
        networking.networkmanager.enable = true;
      };

    State-version =
      { ... }:
      {
        system.stateVersion = "25.11"; # Did you read the comment?
      };

    System-apps =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          git
          vim
          gnumake
          kitty
        ];
      };

    Window-manager =
      { inputs, ... }:
      {
        imports = [
          inputs.rill.nixosModules.default
        ];
      };

    Display-manager =
      { inputs, ... }:
      {
        services.displayManager.ly.enable = true;
      };

    Apps-launcher =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          fuzzel
        ];
      };

    Default-browser =
      { pkgs, inputs, ... }:
      let
        unstable = import inputs.nixpkgs-unstable {
          system = pkgs.stdenv.hostPlatform.system;
          config = {
            allowUnfree = true;
          };
        };
      in
      {
        environment.systemPackages = [
          unstable.google-chrome
        ];
      };
  };
}
