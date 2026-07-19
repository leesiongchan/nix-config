{ pkgs, user, ... }:

{
  users.users.${user}.uid = 502;

  homebrew = {
    casks = [
      # Development
      "mongodb-compass"
      "orbstack"
      "redis-insight"

      # Utility
      "bitwarden"
    ];
  };

  home-manager.users.${user} = {
    home.packages = with pkgs; [
      # Development
      buf
      ghz
    ];

    programs.zed-editor = {
      extensions = [
        "dockerfile"
        "proto"
      ];
      userSettings = {
        agent_servers.cursor.type = "registry";
        lsp.protobuf-language-server.binary.path = "${pkgs.protols}/bin/protols";
      };
    };
  };
}
