{ ... }:

let
  codingFont = "DM Mono";
  terminalFont = "IBM Plex Mono";
  uiFont = "DeepMind Sans";
in
{
  catppuccin.enable = true;
  # tsx IPC pipes fail in Nix sandbox; disable extension, set theme manually below
  catppuccin.vscode.profiles.default.enable = false;

  programs.ghostty.settings = {
    font-family = terminalFont;
  };

  programs.vscodium.profiles.default.userSettings = {
    "editor.fontFamily" = codingFont;
    "editor.fontSize" = 14;
    "terminal.integrated.fontFamily" = terminalFont;
    "terminal.integrated.fontSize" = 14;
    "workbench.colorTheme" = "Catppuccin Mocha";
  };

  programs.zed-editor.userSettings = {
    agent_buffer_font_size = 14;
    buffer_font_family = codingFont;
    terminal.font_family = terminalFont;
    ui_font_family = uiFont;
  };
}
