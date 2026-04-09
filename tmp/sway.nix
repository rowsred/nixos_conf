{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    wl-clipboard-rs # Copy/Paste functionality.
    mako # Notification utility.
  ];

  # Enables Gnome Keyring to store secrets for applications.
  services.gnome.gnome-keyring.enable = true;
  services.displayManager.ly.enable = true;
  # Enable Sway.
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
}
