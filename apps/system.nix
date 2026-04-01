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
    llvmPackages.libclang.lib
    pkg-config
    fastfetch
    nautilus
  ];
  environment.sessionVariables = {
    # Ini akan membuat Cargo/Bindgen selalu bisa menemukan libclang
    LIBCLANG_PATH = "${pkgs.llvmPackages.libclang.lib}/lib";
    # Opsional: Agar compiler C bisa menemukan header clang
    C_INCLUDE_PATH = "${pkgs.llvmPackages.libclang.lib}/lib/clang/${pkgs.lib.versions.major pkgs.llvmPackages.libclang.version}/include";
  };

}
