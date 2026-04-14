# ❄️ NixOS Configuration: Rowsred

A minimal and organized NixOS setup using **flake-parts** and the **Dendritic Pattern**.

## 📂 Structure
modules/
├── system/
│   ├── core/
│   │   ├── boot.nix
│   │   ├── nix-settings.nix
│   │   ├── state-version.nix
│   │   └── trusted-users.nix
│   │
│   ├── kernel/
│   │   ├── hardware.nix
│   │   ├── filesystem.nix
│   │   └── kernel-tuning.nix
│   │
│   ├── services/
│   │   ├── network.nix
│   │   ├── security.nix
│   │   ├── users.nix
│   │   └── power-management.nix
│   │
│   └── packages/
│       └── system-apps.nix
│
├── desktop/
│   ├── environment/
│   │   ├── desktop.nix
│   │   ├── display-manager.nix
│   │   ├── window-manager.nix
│   │   └── compositor.nix
│   │
│   ├── ui-framework/
│   │   ├── theme.nix
│   │   ├── fonts.nix
│   │   └── input.nix
│   │
│   ├── launcher/
│   │   └── app-launcher.nix
│   │
│   └── apps/
│       └── default-browser.nix
│
├── home/
│   ├── shell/
│   │   ├── shell-settings.nix
│   │   └── zsh.nix
│   │
│   ├── git/
│   │   └── git-settings.nix
│   │
│   ├── neovim/
│   │   └── neovim.nix
│   │
│   └── apps/
│       └── user-apps.nix
│
├── features/
│   ├── browser/
│   │   ├── google-chrome.nix
│   │   └── browser.nix
│   │
│   ├── nix/
│   │   ├── flakes.nix
│   │   └── experimental-features.nix
│   │
│   ├── dev/
│   │   └── toolchains.nix
│   │
│   └── media/
│       └── multimedia.nix
│
└── entry/
    ├── config.nix
    └── options.nix

