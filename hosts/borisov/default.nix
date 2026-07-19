{ user, ... }:

{
  homebrew = {
    casks = [
      # AI
      { name = "comfy"; args = { appdir = "~/Applications"; }; }
      { name = "draw-things"; args = { appdir = "~/Applications"; }; }

      # Development
      { name = "xcodes"; args = { appdir = "~/Applications"; }; }

      # Messenger
      { name = "discord"; args = { appdir = "~/Applications"; }; }

      # Networking
      { name = "private-internet-access"; args = { appdir = "~/Applications"; }; }
      { name = "tailscale-app"; args = { appdir = "~/Applications"; }; }
    ];
    masApps = {
      # Browser Extensions
      "JSON Peep for Safari" = 1458969831;
      "Keepa - Price Tracker" = 1533805339;

      # Development
      # "Xcode" = 497799835;
    };
  };

  home-manager.users.${user} = {
    programs.mise.globalConfig.tools = {
      # k8s
      kubectl = "latest";
      "cargo:kdash" = "latest";
    };
  };
}
