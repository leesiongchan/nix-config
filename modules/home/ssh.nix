{ ... }:

{
  # @ref https://github.com/nix-community/home-manager/blob/master/modules/programs/ssh.nix
  programs.ssh = {
    enable = true;

    enableDefaultConfig = false;
  };
}
