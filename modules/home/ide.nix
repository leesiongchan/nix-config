{ pkgs, ... }:

{
  # @ref https://github.com/nix-community/home-manager/blob/master/modules/programs/helix.nix
  programs.helix = {
    enable = true;

    defaultEditor = true;
  };

  # @ref https://github.com/nix-community/home-manager/tree/master/modules/programs/vscode/default.nix
  programs.vscode = {
    enable = true;
    # package = pkgs.vscodium;
    package = pkgs.antigravity;

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
      ];
      userSettings = {
        "editor.minimap.enabled" = false;
        "git.blame.editorDecoration.enabled" = true;
        "workbench.activityBar.location" = "top";

        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";
        "nix.serverSettings" = {
          "nixd" = {
            "formatting" = {
              "command" = [ "nixfmt" ];
            };
          };
        };
      };
    };
  };

  # @ref https://github.com/nix-community/home-manager/blob/master/modules/programs/zed-editor.nix
  programs.zed-editor = {
    enable = true;

    extensions = [
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
      features = {
        edit_prediction_provider = "codestral";
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
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      title_bar = {
        show_branch_icon = true;
      };
    };
  };
}
