{ pkgs, ... }:

{
  home.packages = with pkgs; [
    firefox
    sublime-merge
    zed-editor
  ];
}
