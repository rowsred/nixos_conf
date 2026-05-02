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
          pkgs.vscodium.override {
            commandLineArgs = [
              "--ozone-platform-hint=auto"
              "--ozone-platform=wayland"
              "--enable-features=WaylandWindowDecorations"
            ];
          }
        );
        extensions = with pkgs.vscode-extensions; [
          vscodevim.vim
        ];

        userSettings = {
          "breadcrumbs.enabled" = false;
          "window.commandCenter" = false;
          "editor.minimap.enabled" = false;
          "workbench.activityBar.location" = "hidden";
          "editor.scrollbar.horizontal" = "hidden";
          "editor.scrollbar.vertical" = "hidden";
          "editor.hideCursorInOverviewRuler" = true;
          "workbench.editor.tabActionCloseVisibility" = false;
          "workbench.editor.showTabs" = "single";

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
}
