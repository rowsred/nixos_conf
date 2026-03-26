{ pkgs, inputs, ... }:
let
  unstable = import inputs.nixpkgs-unstable {

  };
in
{
  environment.systemPackages = with pkgs; [
    unstable.firefox
    unstable.kitty
    btop
    ripgrep
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
