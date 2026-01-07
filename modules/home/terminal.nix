{ pkgs, ... }:

{
  # @ref https://github.com/nix-community/home-manager/blob/master/modules/programs/ghostty.nix
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty-bin;

    # @ref https://ghostty.org/docs/config/reference
    settings = {
      shell-integration-features = "ssh-terminfo";
      window-padding-x = 6;
    };
  };
}
