{ inputs, ... }:

{
  flake = {
    nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ../hosts/pc_h61
        inputs.riverKwm.nixosModules.default
        ../apps/system.nix
        ../apps/neovim-nightly.nix
      ];
    };
  };
}
