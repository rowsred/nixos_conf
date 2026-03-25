{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
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
