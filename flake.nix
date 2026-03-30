{
  description = "Description for the project";
  nixConfig = {
    trusted-substituters = [
      "https://nix-community.cachix.org"
      "https://cache.nixos.org"
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    xlibre-overlay.url = "git+https://codeberg.org/takagemacoed/xlibre-overlay";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    riverKwm.url = "/home/row/riverKwm";
  };

  outputs =
    {
      self,
      flake-parts,
      riverKwm,
      ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      imports = [
        ./parts/nixos.nix
      ];
    };
}
