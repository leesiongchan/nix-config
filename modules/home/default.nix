{ homeDir, user, ... }:

{
  imports = [
    ./ide.nix
    ./packages.nix
    ./secrets.nix
    ./shell.nix
    ./ssh.nix
    ./terminal.nix
    ./theme.nix
    ./vcs.nix
  ];

  home = {
    username = user;
    homeDirectory = homeDir;

    stateVersion = "25.11";
  };
}
