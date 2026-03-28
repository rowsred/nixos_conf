{ inputs, pkgs, ... }:
{
  imports = [
    inputs.xlibre-overlay.nixosModules.overlay-xlibre-xserver
    inputs.xlibre-overlay.nixosModules.overlay-xlibre-xf86-input-libinput
  ];

  environment.systemPackages = with pkgs; [
    xclip
    rofi
  ];
  services.xserver.windowManager.dwm = {
    enable = true;
    package = pkgs.dwm.overrideAttrs {
      src = /home/row/nixos_conf/desktop/dwm;
      postInstall = ''
        mkdir -p $out/share/xsessions
        # Pastikan nama file sesuai dengan yang ada di folder dwm kamu
        cp dwm.desktop $out/share/xsessions/
      '';
    };
  };
  services.xserver.enable = true;
  services.displayManager.ly.enable = true;
}
