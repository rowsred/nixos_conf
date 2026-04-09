{ pkgs, inputs, ... }:
{
  programs.niri.enable = true;
  services.displayManager.ly.enable = true;

  environment.systemPackages = with pkgs; [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    fuzzel
    alacritty
    wl-clipboard-rs
  ];

}
