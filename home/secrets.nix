{ config, ... }:

{
  sops = {
    defaultSopsFile = ../secrets.yaml;
    age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";

    secrets = {
      ssh-key.path = "${config.home.homeDirectory}/.ssh/id_ed25519";
    };
  };
}
