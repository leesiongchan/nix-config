{ pkgs, ... }:

{
  home.packages = with pkgs; [
    rtk
  ];

  programs.mcp = {
    enable = true;

    servers = {
      github.url = "https://api.githubcopilot.com/mcp";
    };
  };

  # Coding Agent

  # oh-my-pi
  # home.file.".omp/agent/config.yml".source =
  #   let
  #     yamlFormat = pkgs.formats.yaml { };
  #     ompConfig = {
  #       modelRoles = {
  #         smol = "opencode-go/mimo-v2.5:low";
  #         default = "opencode-go/mimo-v2.5";
  #         slow = "opencode-go/mimo-v2.5-pro:medium";
  #         plan = "opencode-go/glm-5.2:xhigh";
  #         vision = "opencode-go/qwen3.7-plus:medium";
  #         task = "opencode-go/mimo-v2.5:low";
  #         designer = "opencode-go/qwen3.7-plus:high";
  #         advisor = "opencode-go/mimo-v2.5-pro:low";
  #       };
  #       providers = {
  #         webSearch = "perplexity";
  #         kimiApiFormat = "anthropic";
  #       };
  #       symbolPreset = "unicode";
  #       theme = {
  #         dark = "dark-catppuccin";
  #       };
  #       setupVersion = 1;
  #       display = {
  #         showTokenUsage = true;
  #         cacheMissMarker = true;
  #       };
  #       task = {
  #         showResolvedModelBadge = true;
  #       };
  #       hideThinkingBlock = false;
  #       collapseChangelog = true;
  #       memory = {
  #         backend = "mnemopi";
  #       };
  #       checkpoint = {
  #         enabled = true;
  #       };
  #       defaultThinkingLevel = "auto";
  #       browser = {
  #         headless = true;
  #       };
  #       tools = {
  #         approvalMode = "yolo";
  #         discoveryMode = "auto";
  #       };
  #       edit = {
  #         mode = "hashline";
  #       };
  #       mcp = {
  #         discoveryMode = false;
  #       };
  #       plan = {
  #         defaultOnStartup = true;
  #       };
  #       secrets = {
  #         enabled = true;
  #       };
  #     };
  #   in
  #   yamlFormat.generate "omp-config" ompConfig;
  # home.file.".omp/agent/models.yml".source =
  #   let
  #     yamlFormat = pkgs.formats.yaml { };
  #     modelsConfig = {
  #       providers.neuralwatt = {
  #         baseUrl = "https://api.neuralwatt.com/v1";
  #         api = "openai-completions";
  #         apiKey = "NEURALWATT_API_KEY";
  #         authHeader = true;
  #         models = [
  #           {
  #             id = "glm-5.2";
  #             name = "GLM 5.2";
  #             reasoning = true;
  #             thinking = {
  #               minLevel = "low";
  #               maxLevel = "max";
  #               mode = "effort";
  #             };
  #             input = [ "text" ];
  #             contextWindow = 1048576;
  #             maxTokens = 16384;
  #             compat = {
  #               supportsDeveloperRole = false;
  #               supportsReasoningEffort = true;
  #               reasoningEffortMap = {
  #                 low = "low";
  #                 medium = "medium";
  #                 high = "high";
  #                 xhigh = "max";
  #                 max = "max";
  #               };
  #               maxTokensField = "max_tokens";
  #               supportsToolChoice = false;
  #               requiresReasoningContentForToolCalls = true;
  #               requiresAssistantContentForToolCalls = true;
  #             };
  #           }
  #           {
  #             id = "glm-5.2-fast";
  #             name = "GLM 5.2 Fast";
  #             reasoning = false;
  #             input = [ "text" ];
  #             contextWindow = 1048576;
  #             maxTokens = 16384;
  #             compat = {
  #               supportsDeveloperRole = false;
  #               maxTokensField = "max_tokens";
  #               supportsToolChoice = false;
  #             };
  #           }
  #           {
  #             id = "glm-5.2-short";
  #             name = "GLM 5.2 Short";
  #             reasoning = true;
  #             thinking = {
  #               minLevel = "low";
  #               maxLevel = "max";
  #               mode = "effort";
  #             };
  #             input = [ "text" ];
  #             contextWindow = 199680;
  #             maxTokens = 16384;
  #             compat = {
  #               supportsDeveloperRole = false;
  #               supportsReasoningEffort = true;
  #               reasoningEffortMap = {
  #                 low = "low";
  #                 medium = "medium";
  #                 high = "high";
  #                 xhigh = "max";
  #                 max = "max";
  #               };
  #               maxTokensField = "max_tokens";
  #               supportsToolChoice = false;
  #               requiresReasoningContentForToolCalls = true;
  #               requiresAssistantContentForToolCalls = true;
  #             };
  #           }
  #           {
  #             id = "glm-5.2-short-fast";
  #             name = "GLM 5.2 Short Fast";
  #             reasoning = false;
  #             input = [ "text" ];
  #             contextWindow = 199680;
  #             maxTokens = 16384;
  #             compat = {
  #               supportsDeveloperRole = false;
  #               maxTokensField = "max_tokens";
  #               supportsToolChoice = false;
  #             };
  #           }
  #           {
  #             id = "kimi-k2.6";
  #             name = "Kimi K2.6";
  #             reasoning = true;
  #             input = [
  #               "text"
  #               "image"
  #             ];
  #             contextWindow = 262144;
  #             maxTokens = 16384;
  #             compat = {
  #               supportsDeveloperRole = false;
  #               supportsReasoningEffort = false;
  #               maxTokensField = "max_tokens";
  #               supportsToolChoice = false;
  #               requiresReasoningContentForToolCalls = true;
  #               requiresAssistantContentForToolCalls = true;
  #               extraBody = {
  #                 thinking_token_budget = 8000;
  #               };
  #             };
  #           }
  #           {
  #             id = "kimi-k2.6-fast";
  #             name = "Kimi K2.6 Fast";
  #             reasoning = false;
  #             input = [
  #               "text"
  #               "image"
  #             ];
  #             contextWindow = 262144;
  #             maxTokens = 16384;
  #             compat = {
  #               supportsDeveloperRole = false;
  #               maxTokensField = "max_tokens";
  #               supportsToolChoice = false;
  #             };
  #           }
  #           {
  #             id = "kimi-k2.7-code";
  #             name = "Kimi K2.7 Code";
  #             reasoning = true;
  #             input = [
  #               "text"
  #               "image"
  #             ];
  #             contextWindow = 262144;
  #             maxTokens = 16384;
  #             compat = {
  #               supportsDeveloperRole = false;
  #               supportsReasoningEffort = false;
  #               maxTokensField = "max_tokens";
  #               supportsToolChoice = false;
  #               requiresReasoningContentForToolCalls = true;
  #               requiresAssistantContentForToolCalls = true;
  #               extraBody = {
  #                 thinking_token_budget = 8000;
  #               };
  #             };
  #           }
  #           {
  #             id = "qwen3.5-397b";
  #             name = "Qwen 3.5 397B";
  #             reasoning = true;
  #             input = [ "text" ];
  #             contextWindow = 262144;
  #             maxTokens = 16384;
  #             compat = {
  #               supportsDeveloperRole = false;
  #               supportsReasoningEffort = false;
  #               maxTokensField = "max_tokens";
  #               supportsToolChoice = false;
  #               requiresReasoningContentForToolCalls = true;
  #               requiresAssistantContentForToolCalls = true;
  #             };
  #           }
  #           {
  #             id = "qwen3.5-397b-fast";
  #             name = "Qwen 3.5 397B Fast";
  #             reasoning = false;
  #             input = [ "text" ];
  #             contextWindow = 262144;
  #             maxTokens = 16384;
  #             compat = {
  #               supportsDeveloperRole = false;
  #               maxTokensField = "max_tokens";
  #               supportsToolChoice = false;
  #             };
  #           }
  #           {
  #             id = "qwen3.6-35b";
  #             name = "Qwen 3.6 35B";
  #             reasoning = true;
  #             input = [
  #               "text"
  #               "image"
  #             ];
  #             contextWindow = 131072;
  #             maxTokens = 16384;
  #             compat = {
  #               supportsDeveloperRole = false;
  #               supportsReasoningEffort = false;
  #               maxTokensField = "max_tokens";
  #               supportsToolChoice = false;
  #               requiresReasoningContentForToolCalls = true;
  #               requiresAssistantContentForToolCalls = true;
  #             };
  #           }
  #           {
  #             id = "qwen3.6-35b-fast";
  #             name = "Qwen 3.6 35B Fast";
  #             reasoning = false;
  #             input = [
  #               "text"
  #               "image"
  #             ];
  #             contextWindow = 131072;
  #             maxTokens = 16384;
  #             compat = {
  #               supportsDeveloperRole = false;
  #               maxTokensField = "max_tokens";
  #               supportsToolChoice = false;
  #             };
  #           }
  #         ];
  #       };
  #     };
  #   in
  #   yamlFormat.generate "omp-models" modelsConfig;

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
}
