{ pkgs, user, ... }:

{
  users.users.${user}.uid = 502;

  homebrew = {
    casks = [
      # Development
      "cursor"
      "orbstack"
      "redis-insight"
    ];
  };

  home-manager.users.${user} = {
    programs.zed-editor = {
      extensions = [
        "dockerfile"
        "proto"
      ];
      userSettings = {
        lsp.protobuf-language-server.binary.path = "${pkgs.protols}/bin/protols";
      };
    };
  };
}
