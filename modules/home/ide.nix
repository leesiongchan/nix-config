{ pkgs, ... }:

{
  # @ref https://github.com/nix-community/home-manager/blob/master/modules/programs/helix.nix
  programs.helix = {
    enable = true;

    defaultEditor = true;
  };

  # @ref https://github.com/nix-community/home-manager/tree/master/modules/programs/vscode/default.nix
  programs.vscodium = {
    enable = false;

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        # anthropic.claude-code
        # dbaeumer.vscode-eslint
        editorconfig.editorconfig
        # esbenp.prettier-vscode
        # fill-labs.dependi
        jnoortheen.nix-ide
        mkhl.direnv
        oxc.oxc-vscode
        redhat.vscode-yaml
        rust-lang.rust-analyzer
        # sst-dev.opencode
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
      "depsy-lsp"
      "editorconfig"
      "git-firefly"
      "nix"
      "oxc"
      # "tombi"
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
      agent = {
        auto_compact.threshold = "60%";
        default_model = {
          provider = "openai-subscribed";
          model = "gpt-6.1-sol";
          effort = "high";
          enable_thinking = true;
        };
        expand_edit_card = false;
        expand_terminal_card = false;
        message_editor_min_lines = 2;
        show_turn_stats = true;
        tool_permissions.default = "allow";
      };
      agent_servers = {
        claude-acp = {
          type = "registry";
          default_config_options.effort = "high";
        };
        codex-acp = {
          type = "registry";
          default_config_options.reasoning_effort = "high";
        };
        cursor.type = "registry";
        opencode.type = "registry";
      };
      cli_default_open_behavior = "new_window";
      edit_predictions = {
        allow_data_collection = "no";
        mode = "subtle";
        provider = "codestral";
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
      language_models.opencode.show_zen_models = false;
      load_direnv = "shell_hook";
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      title_bar = {
        show_branch_status_icon = true;
      };
    };
  };
}
