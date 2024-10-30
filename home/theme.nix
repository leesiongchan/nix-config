{ pkgs, ... }:

{
  programs.starship.settings = {
    aws.style = "bold #ffb86c";
    cmd_duration.style = "bold #f1fa8c";
    directory.style = "bold #50fa7b";
    hostname.style = "bold #ff5555";
    git_branch.style = "bold #ff79c6";
    git_status.style = "bold #ff5555";
    username = {
      format = "[$user]($style) on ";
      style_user = "bold #bd93f9";
    };
    character = {
      success_symbol = "[λ](bold #f8f8f2)";
      error_symbol = "[λ](bold #ff5555)";
    };
  };

  programs.tmux.plugins = with pkgs.tmuxPlugins; [
    {
      plugin = dracula;
      extraConfig = ''
        set -g @dracula-show-battery false
        set -g @dracula-show-powerline true
        set -g @dracula-refresh-rate 10
      '';
    }
  ];

  programs.zellij.settings = {
    theme = "dracula";
    themes = {
      dracula = {
        fg = [ 248 248 242 ];
        bg = [ 40 42 54 ];
        black = [ 0 0 0 ];
        red = [ 255 85 85 ];
        green = [ 80 250 123 ];
        yellow = [ 241 250 140 ];
        blue = [ 98 114 164 ];
        magenta = [ 255 121 198 ];
        cyan = [ 139 233 253 ];
        white = [ 255 255 255 ];
        orange = [ 255 184 108 ];
      };
    };
  };

  programs.zsh.initExtra = ''
    # Fancy ls colors
    # @ref https://github.com/sharkdp/vivid
    export LS_COLORS="$(${pkgs.vivid}/bin/vivid generate dracula)"
  '';
}
