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

  # oh-my-pi = {
  #   enable = false;

  #   models = {
  #     providers = {
  #       crof = {
  #         baseURL = "https://crof.ai/v1";
  #         api = "openai-responses";
  #         auth = "apiKey";
  #         discovery.type = "openai-models-list";
  #       };
  #     };
  #   };
  # };

  programs.opencode = {
    enable = true;
    enableMcpIntegration = true;

    settings = {
      permission = {
        lsp = "allow";
        question = "allow";
      };
      plugin = [
        # "context-mode"
        "superpowers@git+https://github.com/obra/superpowers.git"
        "@honcho-ai/opencode-honcho"
      ];
      provider = {
        manifest = {
          name = "Manifest";
          npm = "@ai-sdk/openai-compatible";
          options.baseURL = "https://lucy-router.harflix.lol/v1";
          models = {
            auto.name = "Auto";
          };
        };
      };
    };
  };
}
