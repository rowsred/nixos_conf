default :
    @just --list
flake := "."
current_user := `whoami`
nh := "nix run nixpkgs#nh --"
db := "nix run github:nix-community/home-manager"

# Ganti dengan username Anda
linux_me := "row" 
linux_wsl:= "wsl" 

homeL:
    @if [ "{{current_user}}" = "{{linux_me}}" ]; then \
        {{nh}} home switch .; \
    else \
        echo "❌ Bukan user Linux!"; \
        exit 1; \
    fi

homeLdb:
    @if [ "{{current_user}}" = "{{linux_me}}" ]; then \
        {{db}} -- switch --flake .; \
    else \
        echo "❌ Bukan user Linux!"; \
        exit 1; \
    fi

homerm:
    @if [ "{{current_user}}" = "{{linux_me}}" ]; then \
        {{db}} -- uninstall; \
    else \
        echo "❌ Bukan user Linux!"; \
        exit 1; \
    fi

homeW:
    @if [ "{{current_user}}" = "{{linux_wsl}}" ]; then \
        {{nh}} home switch .; \
    else \
        echo "❌ Bukan user wsl!"; \
        exit 1; \
    fi
