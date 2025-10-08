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
    uid = 501;
    home = homeDir;
    shell = pkgs.fish;
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  system = {
    primaryUser = user;

    defaults = {
      dock = {
        autohide = true;
        tilesize = 48;
        largesize = 60;
      };

      finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = false;
        ShowStatusBar = false;
        _FXShowPosixPathInTitle = false;
      };

      NSGlobalDomain = {
        # 120, 94, 68, 35, 25, 15
        InitialKeyRepeat = 15;
        # 120, 90, 60, 30, 12, 6, 2
        KeyRepeat = 2;

        NSAutomaticSpellingCorrectionEnabled = true;
        NSAutomaticCapitalizationEnabled = true;
        NSAutomaticPeriodSubstitutionEnabled = true;
        NSAutomaticWindowAnimationsEnabled = true;
      };
    };

    stateVersion = 6;
  };
}
