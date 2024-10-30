{ config, pkgs, inputs, ... }:

{
  imports = [
    ./home/cli-apps.nix
    ./home/desktop.nix
    ./home/gui-apps.nix
    ./home/k8s.nix
    ./home/mise.nix
    (import ./home/secrets.nix { inherit config; })
    ./home/shell.nix
    ./home/theme.nix
    ./home/vcs.nix
  ];

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  programs.kitty.enable = true;
  wayland.windowManager.hyprland.enable = true;
}