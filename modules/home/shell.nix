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
    sed = "sd";
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

  # @ref https://github.com/nix-community/home-manager/blob/master/modules/programs/starship.nix
  programs.starship = {
    enable = true;
  };
}
