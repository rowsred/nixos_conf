# File: vscode.nix
# Author: rowsred
# Date: 2026-05-02
# Descriptions:
{ ... }:
{
  flake.homeModules.vscode =
    { pkgs, ... }:
    {
      programs.vscode = {
        enable = true;
        package = (
          pkgs.vscode.override {
            commandLineArgs = [
              "--ozone-platform-hint=auto"
              "--ozone-platform=wayland"
              "--enable-features=WaylandWindowDecorations"
            ];
          }
        );
        profiles = {
          default = {
            keybindings = [
              {
                key = "ctrl+j";
                command = "workbench.action.terminal.toggleTerminal";
                when = "terminal.active"; # Opsional: agar hanya aktif saat terminal relevan
              }
              {
                key = "ctrl+j";
                command = "workbench.action.terminal.toggleTerminal";
                when = "!terminal.active";
              }
            ];

            extensions = with pkgs.vscode-extensions; [
              rust-lang.rust-analyzer
              sumneko.lua
              vscodevim.vim
              jnoortheen.nix-ide
              pkief.material-icon-theme
              usernamehw.errorlens
            ];

            userSettings = {
              #auto zoom
              "workbench.sideBar.location" = "right";
              "workbench.startupEditor" = "none";
              "window.zoomLevel" = 1;
              #scrool remove config
              "editor.scrollbar.vertical" = "hidden";
              "editor.scrollbar.horizontal" = "hidden";
              "editor.scrollbar.verticalScrollbarSize" = 0;
              "editor.scrollbar.horizontalScrollbarSize" = 0;
              "editor.folding" = false;
              "workbench.notification.collapse" = true;

              #this for remove topbar
              "workbench.editor.editorActionsLocation" = "hidden";
              "workbench.iconTheme" = "material-icon-theme";
              "breadcrumbs.enabled" = false;
              "editor.minimap.enabled" = false;
              "window.titleBarStyle" = "native";
              "window.menuBarVisibility" = "toggle";
              "window.customTitleBarVisibility" = "never";
              #for nix config
              "nix.enableLanguageServer" = true;

              "vim.leader" = "<space>";
              "vim.insertModeKeyBindings" = [
                {
                  "before" = [
                    "j"
                    "k"
                  ];
                  "after" = [ "<Esc>" ];
                }
              ];
              "vim.normalModeKeyBindingsNonRecursive" = [

                {
                  "before" = [
                    "leader"
                    "c"
                  ];
                  "commands" = [ "workbench.action.closeActiveEditor" ];
                }

                {
                  "before" = [
                    "leader"
                    "x"
                  ];
                  "commands" = [ "workbench.action.previousEditor" ];
                }

                {
                  "before" = [
                    "leader"
                    "l"
                  ];
                  "commands" = [ "workbench.action.nextEditor" ];
                }
                {
                  "before" = [
                    "leader"
                    "e"
                  ];
                  "commands" = [ "workbench.view.explorer" ];
                }
                {
                  "before" = [
                    "leader"
                    "w"
                  ];
                  "commands" = [ "workbench.action.files.save" ];
                }
                {
                  "before" = [
                    "leader"
                    "f"
                  ];
                  "commands" = [ "workbench.action.quickOpen" ];
                }
              ];

              "editor.fontFamily" = "'SFMono Nerd Font', 'monospace'";
              "editor.fontSize" = 12;
              "vim.useSystemClipboard" = true;
              "vim.hlsearch" = true;
              "editor.formatOnSave" = true;
            };
          };

        };
      };
    };
}
