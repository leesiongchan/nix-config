{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Browser
    # firefox

    # Development
    # gitbutler
    # sublime-merge
    yaak

    # Entertainment
    spotify

    # Messenger
    # beeper
  ];
}
