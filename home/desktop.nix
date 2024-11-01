{ pkgs, ... }:

{
  # Gnome
  dconf.settings = {
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
    };
    "org/gnome/mutter" = {
      experimental-features = [ "scale-monitor-framebuffer" ];
    };
    "org/gnome/shell/keybindings" = {
      show-screenshot-ui = [ "Print" "<Super><Shift>S" ];
    };
  };

  programs.gnome-shell = {
    enable = true;

    extensions = with pkgs.gnomeExtensions; [
      { package = brightness-control-using-ddcutil; }
      { package = clipboard-indicator; }
      { package = night-theme-switcher; }
    ];
  };
}
