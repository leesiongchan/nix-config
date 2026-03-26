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
    programs.mise.enable = true;
    programs.vscode = {
      package = pkgs.code-cursor;

      # profiles.default = {
      #   extensions = with pkgs.vscode-extensions; [
      #     bufbuild.vscode-buf
      #   ];
      # };
    };
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
