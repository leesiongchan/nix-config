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
    package = pkgs.lib.mkDefault pkgs.vscodium;

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        anthropic.claude-code
        dbaeumer.vscode-eslint
        # EditorConfig.EditorConfig
        esbenp.prettier-vscode
        jnoortheen.nix-ide
        mkhl.direnv
        redhat.vscode-yaml
        rust-lang.rust-analyzer
        serayuzgur.crates
        # SweepAI.sweep-nes
        tamasfe.even-better-toml
      ];
      userSettings = {
        "editor.formatOnSave" = true;
        "editor.minimap.enabled" = false;
        "explorer.confirmDelete" = false;
        "git.blame.editorDecoration.enabled" = true;
        "workbench.activityBar.location" = "top";

        # "claudeCode.initialPermissionMode" = "plan";
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";
        "nix.serverSettings" = {
          "nixd" = {
            "formatting" = {
              "command" = [ "nixfmt" ];
            };
          };
        };
        "redhat.telemetry.enabled" = false;
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
      agent_servers = {
        claude-acp.type = "registry";
        opencode.type = "registry";
      };
      edit_predictions = {
        mode = "eager";
        provider = "sweep";

        sweep.privacy_mode = true;
      };
      inlay_hints = {
        enabled = true;
      };
      languages = {
        Nix = {
          formatter.external = {
            command = "nixfmt";
            arguments = [
              "--quiet"
              "--"
            ];
          };
          language_servers = [
            "nixd"
            "!nil"
          ];
        };
      };
      load_direnv = "shell_hook";
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
