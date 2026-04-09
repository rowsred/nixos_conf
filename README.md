# ❄️ NixOS Configuration: Rowsred

A minimal and organized NixOS setup using **flake-parts** and the **Dendritic Pattern**.

## 📂 Structure

```text
modules/
├── common/     # Shared variables & global settings
├── system/     # OS Core (Boot, Hardware, Nix, Users)
├── desktop/    # GUI & Window Manager (Rill-WM, Ly)
├── config.nix  # Entry point
└── home/       # User config (Neovim, Dev Apps)
```
