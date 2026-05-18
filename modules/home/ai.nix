{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    (pkgs.symlinkJoin {
      name = "pi-coding-agent";
      buildInputs = [ pkgs.makeWrapper ];
      paths = [ pkgs.pi-coding-agent ];
      postBuild = ''
        wrapProgram $out/bin/pi \
          --set NPM_CONFIG_PREFIX ${config.home.homeDirectory}/.pi/npm/ \
          --prefix PATH : ${
            pkgs.lib.makeBinPath [
              pkgs.nodejs_latest
            ]
          }
      '';
    })
    rtk
  ];

  programs.mcp = {
    enable = true;

    servers = {
      github.url = "https://api.githubcopilot.com/mcp";
    };
  };

  # Coding Agent

  programs.claude-code.enable = true;

  programs.opencode = {
    enable = true;
    enableMcpIntegration = true;

    extraPackages = [ pkgs.uv ];

    settings = {
      permission = {
        lsp = "allow";
        question = "allow";
      };
      plugin = [
        "superpowers@git+https://github.com/obra/superpowers.git"
        "@honcho-ai/opencode-honcho"
      ];
      provider = {
        crof = {
          name = "CrofAI";
          npm = "@ai-sdk/openai-compatible";
          options = {
            baseURL = "https://crof.ai/v1";
          };
          models = {
            deepseek-v4-pro.name = "deepseek-v4-pro";
          };
        };
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
