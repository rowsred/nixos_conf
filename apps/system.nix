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

  environment.systemPackages = with pkgs; [
    unstable.google-chrome
    unstable.kitty
    unstable.vscodium
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
