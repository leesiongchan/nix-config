{ ... }:

{
  # @ref https://github.com/nix-community/home-manager/blob/master/modules/programs/zed-editor.nix
  programs.zed-editor = {
    enable = true;

    extensions = [
      "catppuccin"
      "catppuccin-icons"
      "nix"
    ];
    userSettings = {
      edit_predictions = {
        mode = "subtle";
      };
      languages = {
        Nix = {
          formatter = {
            external = {
              command = "nixfmt";
              arguments = [
                "--quiet"
                "--"
              ];
            };
          };
          language_servers = [
            "nixd"
            "!nil"
          ];
        };
      };
    };
  };
}
