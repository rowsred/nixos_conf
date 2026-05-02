default :
    @just --list
flake := "."
current_user := `whoami`
nh := "nix run nixpkgs#nh --"

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

homeW:
    @if [ "{{current_user}}" = "{{linux_wsl}}" ]; then \
        {{nh}} home switch .; \
    else \
        echo "❌ Bukan user wsl!"; \
        exit 1; \
    fi
