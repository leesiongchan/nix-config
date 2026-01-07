{ ... }:

let
  codingFont = "DM Mono";
  terminalFont = "IBM Plex Mono";
  uiFont = "DeepMind Sans";
in
{
  catppuccin.enable = true;

  programs.ghostty.settings = {
    font-family = terminalFont;
  };

  programs.vscode.profiles.default.userSettings = {
    "editor.fontFamily" = codingFont;
    "editor.fontSize" = 14;
    "terminal.integrated.fontFamily" = terminalFont;
    "terminal.integrated.fontSize" = 14;
  };

  programs.zed-editor.userSettings = {
    agent_buffer_font_size = 14;
    buffer_font_family = codingFont;
    terminal.font_family = terminalFont;
    ui_font_family = uiFont;
  };
}
