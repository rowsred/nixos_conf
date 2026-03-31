{
  pkgs,
  inputs,
  ...
}:
let
  unstable = import inputs.nixpkgs-unstable {
    config = {
      allowUnfree = true;
    };

  };
in
{
  services.displayManager.ly.enable = true;

  environment.systemPackages = with pkgs; [
    unstable.google-chrome
    unstable.vscodium
    unstable.kitty
    unstable.fuzzel
    btop
    ripgrep
    fd
    rustup
    gnumake
    fzf
    tmux
    rsync
    unzip
    wget
    starship
    clang
    fastfetch
    nautilus
  ];

}
