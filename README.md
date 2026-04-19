# ❄️ NixOS Configuration: Rowsred

A minimal and organized NixOS setup using **flake-parts** and the **Dendritic Pattern**.

## 📂 Structure
```
tree modules/
modules/
├── home
│   ├── code-editor
│   │   ├── code-editor-group.nix
│   │   └── neovim.nix
│   ├── dev
│   │   ├── dev-group.nix
│   │   ├── git-settings.nix
│   │   └── shell-settings.nix
│   ├── dotfiles-manager.nix
│   └── home-root.nix
├── nixos
│   ├── nixos-options.nix
│   └── nixos-root.nix
└── system
    ├── core
    │   ├── boot.nix
    │   ├── core-group.nix
    │   ├── hardware.nix
    │   ├── nix
    │   │   ├── features-flake.nix
    │   │   ├── nix-group.nix
    │   │   └── trusted-users.nix
    │   ├── state-version.nix
    │   └── users.nix
    ├── desktop
    │   ├── apps
    │   │   ├── apps-group.nix
    │   │   ├── browser
    │   │   │   ├── browser-group.nix
    │   │   │   └── google-chrome.nix
    │   │   ├── podman.nix
    │   │   └── system-apps.nix
    │   ├── desktop-group.nix
    │   ├── display-manager.nix
    │   └── wayland
    │       ├── app-launcher.nix
    │       ├── rill-wm.nix
    │       ├── shell
    │       └── wayland-group.nix
    ├── services
    │   ├── network.nix
    │   └── services-group.nix
    └── system-root.nix
```
