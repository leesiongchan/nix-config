{ pkgs, ... }:

{
  # @ref https://github.com/nix-community/home-manager/blob/master/modules/programs/zsh.nix
  programs.zsh = {
    enable = true;

    shellAliases = {
      cat = "bat";
      df = "dysk";
      du = "dust";
      find = "fd";
      grep = "rg";
      ls = "eza";
      ps = "procs";
      tree = "broot";
    };

    # Framework
    oh-my-zsh = {
      enable = true;

      extraConfig = ''
        # @ref https://github.com/ohmyzsh/ohmyzsh/wiki/Settings#disable_magic_functions
        DISABLE_MAGIC_FUNCTIONS=true
      '';
      plugins = [ "git" "kubectl" ];
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
