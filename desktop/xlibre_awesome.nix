{ inputs, pkgs, ... }:
{
  imports = [
    inputs.xlibre-overlay.nixosModules.overlay-xlibre-xserver
    inputs.xlibre-overlay.nixosModules.overlay-xlibre-xf86-input-libinput
  ];

  environment.systemPackages = with pkgs; [
    kitty
    firefox
    xclip
    rofi
  ];
  services.xserver.windowManager.awesome = {
    enable = true;
  };
  services.xserver.enable = true;
  services.displayManager.ly.enable = true;
}
