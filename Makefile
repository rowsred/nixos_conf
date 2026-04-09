

def:

os:
	sudo nixos-rebuild switch --flake --impure
test:
	sudo nixos-rebuild test --flake --impure
home:
	nix run home-manager/master -- switch --impure --flake .

