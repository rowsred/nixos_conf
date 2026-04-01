{ inputs, ... }:

{
  flake = {
    nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ../hosts/pc_h61
        inputs.kwm.nixosModules.default
        inputs.rill.nixosModules.default
        ../apps/system.nix
        ../apps/neovim-nightly.nix
      ];
    };
  };
}
