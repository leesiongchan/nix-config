{ ... }:

{
  # @ref https://github.com/nix-community/home-manager/blob/master/modules/programs/helix.nix
  programs.helix = {
    enable = true;

    defaultEditor = true;
  };

  # @ref https://github.com/nix-community/home-manager/blob/master/modules/programs/zed-editor.nix
  programs.zed-editor = {
    enable = true;

    extensions = [
      "catppuccin"
      "catppuccin-icons"
      "git-firefly"
      "nix"
      "toml"
    ];
    userKeymaps = [
      {
        context = "Workspace";
        bindings = {
          cmd-w = null;
        };
      }
    ];
    userSettings = {
      edit_predictions = {
        mode = "subtle";
      };
      inlay_hints = {
        enabled = true;
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
      title_bar = {
        show_branch_icon = true;
      };
    };
  };
}
