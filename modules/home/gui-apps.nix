{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Browser
    firefox

    # Development
    # gitbutler
    yaak

    # Entertainment
    spotify

    # Messenger
    # beeper
  ];
}
