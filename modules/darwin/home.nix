{ pkgs, user, ... }:

{
  home-manager.users.${user} = {
    # Trick to enable configuration without installing package
    # @see https://github.com/nix-community/home-manager/issues/4763
    programs.ghostty.package = pkgs.emptyDirectory;
    programs.ghostty.installBatSyntax = false;
    programs.zed-editor.package = pkgs.emptyDirectory;
  };
}
