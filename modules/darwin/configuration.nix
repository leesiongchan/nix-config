{
  homeDir,
  hostname,
  pkgs,
  user,
  ...
}:

{
  networking.hostName = hostname;

  # Enable to use fish as default shell
  programs.fish.enable = true;

  # knownUsers & uid are required for default shell to work properly
  # @see https://github.com/LnL7/nix-darwin/issues/1237#issuecomment-2562242340
  users.knownUsers = [ user ];
  users.users.${user} = {
    uid = pkgs.lib.mkDefault 501;
    home = homeDir;
    shell = pkgs.fish;
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  system = {
    primaryUser = user;

    defaults = {
      dock = {
        autohide = true;
        tilesize = 40;
        largesize = 56;

        expose-group-apps = true;
        minimize-to-application = true;

        # @see https://nix-darwin.github.io/nix-darwin/manual/#opt-system.defaults.dock.wvous-tl-corner
        wvous-tl-corner = 1;
        # wvous-tl-corner = 14; # Quick Note
        wvous-tr-corner = 1;
        wvous-bl-corner = 2; # Mission Control
        wvous-br-corner = 4; # Desktop
      };

      finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = false;
        ShowStatusBar = false;
        _FXShowPosixPathInTitle = false;
      };

      trackpad = {
        ActuationStrength = 0;
        Clicking = true;
        FirstClickThreshold = 0;
        SecondClickThreshold = 0;
        TrackpadThreeFingerDrag = true;
      };

      NSGlobalDomain = {
        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.trackpad.forceClick" = true;

        # 120, 94, 68, 35, 25, 15
        InitialKeyRepeat = 15;
        # 120, 90, 60, 30, 12, 6, 2
        KeyRepeat = 2;

        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSAutomaticWindowAnimationsEnabled = true;
      };
    };

    stateVersion = 6;
  };
}
