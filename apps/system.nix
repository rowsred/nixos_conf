{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
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
