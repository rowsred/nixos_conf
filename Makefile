

def:

os:
	sudo nixos-rebuild switch --flake . 
test:
	sudo nixos-rebuild test --flake .
home:
	nix run home-manager/master -- switch --flake .

unhome:
	nix run home-manager/master -- uninstall

