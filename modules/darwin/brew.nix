{ config, ... }:

{
  homebrew = {
    enable = true;

    casks = import ./casks.nix;
    masApps = import ./mas-apps.nix;

    caskArgs.no_quarantine = true;
    onActivation = {
      autoUpdate = false;
      upgrade = true;
      cleanup = "zap";
    };
    taps = builtins.attrNames config.nix-homebrew.taps;
  };
}
