{
  config,
  pkgs,
  user,
  ...
}:

{
  imports = [
    ./configuration.nix
  ];

  homebrew = {
    enable = true;

    brews = import ./brews.nix;
    casks = import ./casks.nix;
    masApps = import ./mas-apps.nix;

    onActivation = {
      autoUpdate = false;
      upgrade = true;
      cleanup = "zap";
    };
    taps = builtins.attrNames config.nix-homebrew.taps;
  };

  # Disable program installations in Home Manager to prevent clashing with Homebrew Cask.
  # @see https://discourse.nixos.org/t/mix-home-manager-and-brew/67171
  home-manager.users.${user} = {
    programs.zed-editor.package = pkgs.emptyDirectory;
  };

  # We use `--determinate` flag which will use Determinate distribution.
  # Determinate manages the Nix installation itself so we need to disable it.
  nix.enable = false;
}
