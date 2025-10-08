{ hostname, pkgs, ... }:

{
  networking.hostName = hostname;

  # Enable to use fish as default shell
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  # Enable the GNOME Desktop Environment
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Disable GNOME's suite of applications
  services.gnome.core-apps.enable = false;
  services.gnome.core-developer-tools.enable = false;
  services.gnome.games.enable = false;
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-user-docs
  ];

  system.stateVersion = "25.11";
}
