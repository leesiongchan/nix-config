{ pkgs, ... }:

let
  codingFont = "DM Mono";
  terminalFont = "IBM Plex Mono";

  lightTheme = "Catppuccin Latte";
  darkTheme = "Catppuccin Mocha";
in
{
  programs.bat.themes = {
    catppuccin-mocha = {
      src = pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "bat";
        rev = "6810349b28055dce54076712fc05fc68da4b8ec0";
        hash = "sha256-lJapSgRVENTrbmpVyn+UQabC9fpV1G1e+CdlJ090uvg=";
      };
      file = "themes/Catppuccin%20Mocha.tmTheme";
    };
  };

  programs.fish.shellInit = ''
    # Fancy ls colors
    # @ref https://github.com/sharkdp/vivid
    set -gx LS_COLORS "$(${pkgs.vivid}/bin/vivid generate catppuccin-mocha)"
  '';

  programs.ghostty.settings = {
    font-family = terminalFont;
    theme = darkTheme;
  };

  # @ref https://github.com/catppuccin/starship/blob/main/starship.toml
  programs.starship.settings = {
    palette = "catppuccin_mocha";
    character = {
      error_symbol = "[[󰄛](red) ❯](peach)";
      success_symbol = "[[󰄛](green) ❯](peach)";
      vimcmd_symbol = "[󰄛 ❮](subtext1)";
    };
    directory = {
      style = "bold lavender";
      truncation_length = 4;
    };
    git_branch = {
      style = "bold mauve";
    };
    palettes.catppuccin_mocha = {
      rosewater = "#f5e0dc";
      flamingo = "#f2cdcd";
      pink = "#f5c2e7";
      mauve = "#cba6f7";
      red = "#f38ba8";
      maroon = "#eba0ac";
      peach = "#fab387";
      yellow = "#f9e2af";
      green = "#a6e3a1";
      teal = "#94e2d5";
      sky = "#89dceb";
      sapphire = "#74c7ec";
      blue = "#89b4fa";
      lavender = "#b4befe";
      text = "#cdd6f4";
      subtext1 = "#bac2de";
      subtext0 = "#a6adc8";
      overlay2 = "#9399b2";
      overlay1 = "#7f849c";
      overlay0 = "#6c7086";
      surface2 = "#585b70";
      surface1 = "#45475a";
      surface0 = "#313244";
      base = "#1e1e2e";
      mantle = "#181825";
      crust = "#11111b";
    };
  };

  programs.zsh.initContent = ''
    # Fancy ls colors
    # @ref https://github.com/sharkdp/vivid
    export LS_COLORS="$(${pkgs.vivid}/bin/vivid generate catppuccin-mocha)"
  '';

  programs.zed-editor.userSettings = {
    buffer_font_family = codingFont;
    icon_theme = {
      mode = "dark";
      light = lightTheme;
      dark = darkTheme;
    };
    terminal.font_family = terminalFont;
    theme = {
      mode = "dark";
      light = lightTheme;
      dark = darkTheme;
    };
  };
}
