{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ccusage
    rtk
  ];

  # @ref https://github.com/nix-community/home-manager/blob/master/modules/programs/herdr.nix
  programs.herdr = {
    enable = true;
  };

  programs.mcp = {
    enable = true;

    servers = {
      github.url = "https://api.githubcopilot.com/mcp";
    };
  };

  # Coding Agent

  programs.claude-code = {
    enable = true;
  };

  # oh-my-pi
  programs.mise.globalConfig.tools."npm:@oh-my-pi/pi-coding-agent" = "latest";
  home.file.".omp/agent/config.yml".source =
    let
      yamlFormat = pkgs.formats.yaml { };
      ompConfig = {
        modelRoles = {
          smol = "opencode-go/mimo-v2.5:low";
          default = "opencode-go/mimo-v2.5-pro:medium";
          slow = "opencode-go/kimi-k3:high";
          plan = "opencode-go/glm-5.2:medium";
          vision = "opencode-go/qwen3.7-plus:medium";
          task = "opencode-go/mimo-v2.5:low";
          designer = "opencode-go/qwen3.7-plus:high";
          advisor = "opencode-go/mimo-v2.5:medium";
          tiny = "opencode-go/deepseek-v4-flash:high";
        };
        providers = {
          webSearch = "perplexity";
          kimiApiFormat = "anthropic";
        };
        symbolPreset = "unicode";
        theme = {
          dark = "dark-catppuccin";
        };
        setupVersion = 1;
        display = {
          showTokenUsage = true;
          cacheMissMarker = true;
        };
        task = {
          showResolvedModelBadge = true;
        };
        hideThinkingBlock = false;
        collapseChangelog = true;
        memory = {
          backend = "mnemopi";
        };
        checkpoint = {
          enabled = true;
        };
        defaultThinkingLevel = "auto";
        browser = {
          headless = true;
        };
        tools = {
          approvalMode = "yolo";
          discoveryMode = "auto";
        };
        edit = {
          mode = "hashline";
        };
        mcp = {
          discoveryMode = false;
        };
        plan = {
          defaultOnStartup = true;
        };
        secrets = {
          enabled = true;
        };
        advisor = {
          enabled = true;
          subagents = false;
        };
      };
    in
    yamlFormat.generate "omp-config" ompConfig;
  home.file.".omp/agent/models.yml".source =
    let
      yamlFormat = pkgs.formats.yaml { };
      modelsConfig = {
        providers = {
          crof = {
            baseUrl = "https://crof.ai/v1";
            api = "openai-completions";
            apiKey = "CROFAI_API_KEY";
            auth = "apiKey";
            discovery = {
              type = "openai-models-list";
            };
          };
          neuralwatt = {
            baseUrl = "https://api.neuralwatt.com/v1";
            api = "openai-completions";
            apiKey = "NEURALWATT_API_KEY";
            auth = "apiKey";
            discovery = {
              type = "openai-models-list";
            };
          };
        };
      };

    in
    yamlFormat.generate "omp-models" modelsConfig;

  programs.opencode = {
    enable = false;
    enableMcpIntegration = true;

    settings = {
      permission = {
        lsp = "allow";
        question = "allow";
      };
      plugin = [
        # "context-mode"
        # "superpowers@git+https://github.com/obra/superpowers.git"
        # "@honcho-ai/opencode-honcho"
      ];
      # provider = {
      #   manifest = {
      #     name = "Manifest";
      #     npm = "@ai-sdk/openai-compatible";
      #     options.baseURL = "https://lucy-router.harflix.lol/v1";
      #     models = {
      #       auto.name = "Auto";
      #     };
      #   };
      # };
    };
  };

  programs.pi-coding-agent = {
    enable = false;
  };
}
