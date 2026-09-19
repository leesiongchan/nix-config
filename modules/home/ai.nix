{ config, lib, pkgs, ... }:

let
  agentContext = ''
    - This is a Nix system: most CLI tools are not installed globally.
      If a command is missing, retry it prefixed with `,` (comma), e.g.
      `, jq '.foo' file.json` — it runs the nixpkgs package on demand
      without installing it. @ref https://github.com/nix-community/comma
    - When composing shell commands, prefer these modern CLI replacements:
      `rg` instead of `grep`, `bat` instead of `cat`, `fd` instead of `find`,
      `jaq` instead of `jq`, `eza` instead of `ls`, `tspin` instead of `tail`.
  '';

  # Agent Skills
  # @ref https://github.com/addyosmani/agent-skills
  addyosmaniAgentSkillsSrc = pkgs.fetchFromGitHub {
    owner = "addyosmani";
    repo = "agent-skills";
    rev = "c004a74784a08295d52749b04cda634125b9a581";
    sha256 = "1qilnbfbs7a4971w3szdsx0il6xl7c9wz68p13rs624qymnp5505";
  };
  # @ref https://github.com/vercel-labs/agent-browser
  agentBrowserSrc = pkgs.fetchFromGitHub {
    owner = "vercel-labs";
    repo = "agent-browser";
    rev = "aff6125c023b810ea3f2e5deec5379e9a4270bdc";
    sha256 = "0p6p507m8bifgivh1l8p80p3iddbxqhaq9zm33850x6f46afkr8b";
  };
  # @ref https://github.com/apollographql/skills
  apolloSkillsSrc = pkgs.fetchFromGitHub {
    owner = "apollographql";
    repo = "skills";
    rev = "c288eb80629dd2309eed81f23d693f66a452d043";
    sha256 = "1zq2hdbw93b8q03wh1151m95s29affiq8in8rv80pixpszdawab1";
  };
  # @ref https://github.com/gamedev-skills/awesome-gamedev-agent-skills
  gamedevAgentSkillsSrc = pkgs.fetchFromGitHub {
    owner = "gamedev-skills";
    repo = "awesome-gamedev-agent-skills";
    rev = "b105e1cf617adf0b68ed98790a716bbb60993179";
    sha256 = "1dg2za1203bxriksmnagwrs48cak52vk0dr3b5dsdcpdhfxcbcnw";
  };
  # @ref https://github.com/supabase/agent-skills
  supabaseAgentSkillsSrc = pkgs.fetchFromGitHub {
    owner = "supabase";
    repo = "agent-skills";
    rev = "8331f910845103c08d51f6ca1d86ebb7d1f745e3";
    sha256 = "1y3m591sqvmwqw9dyf143f2j2jj5j21rcrlilds2vzaiqy1sfgvj";
  };
  # @ref https://github.com/obra/superpowers
  superpowersSrc = pkgs.fetchFromGitHub {
    owner = "obra";
    repo = "superpowers";
    rev = "b36e0829c6d0140e93cfef2ca599b1b07d4a7797";
    sha256 = "050ay1nkgbk8ph8lj7waqrkkchnsmyq1m6qy0zwnfbal8wxqvh8j";
  };
  # @ref https://github.com/sveltejs/ai-tools
  svelteAiToolsSrc = pkgs.fetchFromGitHub {
    owner = "sveltejs";
    repo = "ai-tools";
    rev = "015ef457ac1d77a606ee3bf7ca4052d236d324aa";
    sha256 = "0dl99y7lg4caiyv85q3lmv3dndkkrq7ls3hc01wdh1z60l6xn350";
  };
  # @ref https://github.com/vercel-labs/agent-skills
  vercelAgentSkillsSrc = pkgs.fetchFromGitHub {
    owner = "vercel-labs";
    repo = "agent-skills";
    rev = "063bee94c3f4df8453406c830b0a7df0f2860278";
    sha256 = "07y8vkfyg44szky962d3035kjz3jd8by5iqlgxa5nhnfkmzqjd5m";
  };
in
{
  home.packages = with pkgs; [
    agent-browser
    rtk
  ];

  # @ref https://agent-browser.dev/engines/lightpanda
  home.file.".agent-browser/config.json".text = builtins.toJSON {
    engine = "lightpanda";
  };

  # @ref https://github.com/nix-community/home-manager/blob/master/modules/programs/herdr.nix
  programs.herdr = {
    enable = true;
  };

  # @ref https://github.com/Kyure-A/agent-skills-nix
  # (nix-community/home-manager's own programs.agent-skills is still an open
  # PR: https://github.com/nix-community/home-manager/pull/9247)
  programs.agent-skills = {
    enable = true;

    sources = {
      agent-browser = {
        path = agentBrowserSrc;
        subdir = "skills";
      };
      # @ref https://skills.sh/vercel-labs/agent-skills/web-design-guidelines
      vercel-agent-skills = {
        path = vercelAgentSkillsSrc;
        subdir = "skills";
        filter.nameRegex = "^web-design-guidelines$";
      };
      # @ref https://skills.sh/supabase/agent-skills/supabase-postgres-best-practices
      supabase-agent-skills = {
        path = supabaseAgentSkillsSrc;
        subdir = "skills";
        filter.nameRegex = "^supabase-postgres-best-practices$";
      };
      # @ref https://skills.sh/addyosmani/agent-skills
      addyosmani-agent-skills = {
        path = addyosmaniAgentSkillsSrc;
        subdir = "skills";
        filter.nameRegex = "^(api-and-interface-design|observability-and-instrumentation|security-and-hardening)$";
      };
      # @ref https://skills.sh/apollographql/skills/rust-best-practices
      apollo-skills = {
        path = apolloSkillsSrc;
        subdir = "skills";
        filter.nameRegex = "^rust-best-practices$";
      };
      # @ref https://skills.sh/sveltejs/ai-tools/svelte-core-bestpractices
      svelte-ai-tools = {
        path = svelteAiToolsSrc;
        subdir = "plugins/claude/svelte/skills";
        filter.nameRegex = "^svelte-core-bestpractices$";
      };
      # @ref https://skills.sh/gamedev-skills/awesome-gamedev-agent-skills/bevy-ecs
      gamedev-agent-skills = {
        path = gamedevAgentSkillsSrc;
        subdir = "skills/other-engines";
        filter.nameRegex = "^bevy-ecs$";
      };
    };

    skills.enableAll = true;

    targets = {
      claude.enable = true;
      codex.enable = true;
      omp = {
        enable = true;
        dest = "$HOME/.omp/agent/skills";
      };
      pi.enable = true;
    };
  };

  programs.mcp = {
    enable = true;

    servers = {
      context7.url = "https://mcp.context7.com/mcp";
      # @ref https://github.com/utensils/mcp-nixos
      nixos.command = "${pkgs.mcp-nixos}/bin/mcp-nixos";
    };
  };

  # Coding Agent

  programs.claude-code = {
    enable = true;
    enableMcpIntegration = true;

    context = agentContext;
    plugins = {
      superpowers = superpowersSrc;
    };
    # @ref https://github.com/nix-community/home-manager/blob/master/modules/programs/claude-code/options.nix
    settings = {
      advisorModel = "opus";
      autoCompactWindow = 500000;
      effortLevel = "medium";
      model = "opus";
      # modelSettings."claude-opus-5".effortLevel = "medium";
      permissions = {
        defaultMode = "auto";
        deny = [
          "Read(./.env)"
          "Read(./secrets/**)"
        ];
        allow = [
          "Bash(git diff:*)"
          "Bash(git status:*)"
          "Bash(git log:*)"
        ];
      };
      # cship, not starship's own built-in claude-code profile: it adds a
      # native 5h/weekly rate-limit module starship still lacks
      # (github.com/starship/starship#7441). Configured via the `[cship]`
      # table in starship.toml; see modules/home/shell.nix.
      # @ref https://github.com/stephenleo/cship
      statusLine = {
        type = "command";
        command = "cship";
      };
      # theme = "dark";
      tui = "fullscreen";
      useAutoModeDuringPlan = true;
    };
  };
  # Claude Code's settings.json has a background worker deletes the store
  # symlink outright rather than just failing to write, silently dropping every setting.
  # @ref https://github.com/nix-community/home-manager/issues/9831
  home.file."${config.home.homeDirectory}/.claude/settings.json".enable = false;
  home.activation.claudeCodeMutableSettings =
    let
      generated = config.home.file."${config.home.homeDirectory}/.claude/settings.json".source;
      jaq = lib.getExe pkgs.jaq;
    in
    lib.hm.dag.entryAfter [ "linkGeneration" ] ''
      claudeSettings="$HOME/.claude/settings.json"
      tmp="$(mktemp -d)"
      # a leftover symlink would make `install` follow it into the read-only store
      if [ -L "$claudeSettings" ]; then
        rm -f "$claudeSettings"
      fi
      if [ -f "$claudeSettings" ]; then
        cp "$claudeSettings" "$tmp/live.json"
      else
        echo '{}' > "$tmp/live.json"
      fi
      # (jaq slurps each file argument separately, hence the cat)
      cat "$tmp/live.json" ${generated} | ${jaq} -s '.[0] * .[1]' > "$tmp/settings.json"
      run install -m0644 "$tmp/settings.json" "$claudeSettings"
      rm -rf "$tmp"
    '';

  programs.codex = {
    enable = true;
    enableMcpIntegration = true;

    contextOverride = agentContext;
    plugins = [ superpowersSrc ];
    # @ref https://github.com/nix-community/home-manager/blob/master/modules/programs/codex/options.nix
    settings = {
      approval_policy = "on-request";
      model = "gpt-5.6-terra";
      model_reasoning_effort = "medium";
      notice.hide_rate_limit_model_nudge = true;
      sandbox_mode = "workspace-write";
      service_tier = "default";
      status_line_use_colors = true;
      tui = {
        status_line = [
          "model-with-reasoning"
          "current-dir"
          "git-branch"
          "run-state"
          "context-used"
          "five-hour-limit"
          "weekly-limit"
        ];
      };
    };
  };
  # Codex writes runtime state (project trust, /model picks) back into
  # config.toml, which fails against a Nix-store symlink (re-triggering the
  # trust prompt every launch). Materialise a real file instead, merged with
  # whatever codex already wrote; Nix-defined keys win on conflict.
  # @ref https://github.com/nix-community/home-manager/issues/9397
  home.file.".codex/config.toml".enable = false;
  home.activation.codexMutableConfig =
    let
      generated = config.home.file.".codex/config.toml".source;
      jaq = lib.getExe pkgs.jaq;
      remarshal = lib.getExe pkgs.remarshal;
    in
    lib.hm.dag.entryAfter [ "linkGeneration" ] ''
      codexConfig="$HOME/.codex/config.toml"
      tmp="$(mktemp -d)"
      # a leftover symlink would make `install` follow it into the read-only store
      if [ -L "$codexConfig" ]; then
        rm -f "$codexConfig"
      fi
      if [ -f "$codexConfig" ]; then
        ${remarshal} --if toml --of json "$codexConfig" > "$tmp/live.json"
      else
        echo '{}' > "$tmp/live.json"
      fi
      ${remarshal} --if toml --of json ${generated} > "$tmp/nix.json"
      # (jaq slurps each file argument separately, hence the cat)
      cat "$tmp/live.json" "$tmp/nix.json" | ${jaq} -s '.[0] * .[1]' \
        | ${remarshal} --if json --of toml > "$tmp/config.toml"
      run install -m0644 "$tmp/config.toml" "$codexConfig"
      rm -rf "$tmp"
    '';

  # @ref https://github.com/can1357/oh-my-pi/blob/main/docs/system-prompt-customization.md
  home.file.".omp/agent/APPEND_SYSTEM.md".text = agentContext;

  # @ref https://github.com/can1357/oh-my-pi/blob/main/nix/home-manager.nix
  programs.omp = {
    enable = true;

    settings = {
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
      # theme.dark = "dark-catppuccin";
      setupVersion = 1;
      display = {
        showTokenUsage = true;
        cacheMissMarker = true;
      };
      task.showResolvedModelBadge = true;
      hideThinkingBlock = false;
      collapseChangelog = true;
      memory.backend = "mnemopi";
      checkpoint.enabled = true;
      defaultThinkingLevel = "auto";
      browser.headless = true;
      tools = {
        approvalMode = "yolo";
        discoveryMode = "auto";
      };
      edit.mode = "hashline";
      mcp.discoveryMode = false;
      plan.defaultOnStartup = true;
      secrets.enabled = true;
      advisor = {
        enabled = true;
        subagents = false;
      };
    };
  };

  programs.opencode = {
    enable = false;
    enableMcpIntegration = true;

    settings = {
      permission = {
        lsp = "allow";
        question = "allow";
      };
    };
  };

  programs.pi-coding-agent = {
    enable = false;
  };
}
