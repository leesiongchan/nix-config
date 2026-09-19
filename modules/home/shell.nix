{ pkgs, ... }:

let
  shellAliases = {
    cat = "bat";
    df = "dysk";
    dig = "doggo";
    du = "dust";
    find = "fd";
    grep = "rg";
    jq = "jaq";
    kubectl = "kubecolor";
    ls = "eza";
    ping = "gping";
    pkill = "pik";
    ps = "procs";
    # sed = "sd";
    tail = "tspin";
    tree = "broot";
    vi = "hx";
  };
in
{
  # @ref https://github.com/nix-community/home-manager/blob/master/modules/programs/direnv.nix
  programs.direnv = {
    enable = true;

    nix-direnv.enable = true;
  };

  # @ref https://github.com/nix-community/home-manager/blob/master/modules/programs/fish.nix
  programs.fish = {
    inherit shellAliases;
    enable = true;

    plugins = [
      {
        name = "plugin-git";
        src = pkgs.fishPlugins.plugin-git.src;
      }
      {
        name = "plugin-kubectl";
        src = pkgs.fetchFromGitHub {
          owner = "blackjid";
          repo = "plugin-kubectl";
          rev = "b13993eac0dcce9cb07c3c7e23dabc8b1e1f0832";
          hash = "sha256-wCyqszs1bMtxkbGMNLJwziCcaitr/btWkhDxpGDeEQE=";
        };
      }
    ];
  };


  home.packages = with pkgs; [
    cship
  ];

  # @ref https://github.com/nix-community/home-manager/blob/master/modules/programs/starship.nix
  programs.starship = {
    enable = true;

    # cship (Claude Code statusline renderer) has no config file of its own:
    # it discovers a `[cship]` table straight out of the same starship.toml.
    # It also doesn't render anything without a `[cship]` table present at
    # all (no built-in fallback layout), so this is upstream's own default
    # config verbatim, straight from its install.sh, not a customization.
    # @ref https://github.com/stephenleo/cship
    settings.cship = {
      lines = [
        "$directory$git_branch$git_status$python$nodejs$rust | $cship.model $cship.cost $cship.context_bar $cship.usage_limits"
      ];

      model = {
        symbol = "🤖 ";
        style = "bold cyan";
      };

      context_bar = {
        width = 10;
        style = "fg:#7dcfff";
        warn_threshold = 40.0;
        warn_style = "fg:#e0af68";
        critical_threshold = 70.0;
        critical_style = "bold fg:#f7768e";
      };

      cost = {
        symbol = "💰 ";
        style = "fg:#a9b1d6";
        warn_threshold = 2.0;
        warn_style = "fg:#e0af68";
        critical_threshold = 5.0;
        critical_style = "bold fg:#f7768e";
      };

      # starship's own claude-code profile has no 5h/weekly rate-limit
      # module yet (github.com/starship/starship#7441); cship's native
      # usage_limits module covers exactly that gap.
      usage_limits = {
        five_hour_format = "⌛ 5h {pct}% ({reset})";
        seven_day_format = "📅 7d {pct}% ({reset})";
        separator = " ";
        warn_threshold = 60.0;
        warn_style = "fg:#e0af68";
        critical_threshold = 80.0;
        critical_style = "bold fg:#f7768e";
      };
    };
  };

  # @ref https://github.com/nix-community/home-manager/blob/master/modules/programs/zsh.nix
  programs.zsh = {
    inherit shellAliases;
    enable = true;

    # Framework
    oh-my-zsh = {
      enable = true;

      extraConfig = ''
        # @ref https://github.com/ohmyzsh/ohmyzsh/wiki/Settings#disable_magic_functions
        DISABLE_MAGIC_FUNCTIONS=true
      '';
      plugins = [
        "git"
        "kubectl"
      ];
    };

    # Plugins
    autosuggestion.enable = true;
    historySubstringSearch.enable = true;
    syntaxHighlighting.enable = true;
  };
}
