{ homeDir, ... }:

{
  sops = {
    defaultSopsFile = ../../secrets.yaml;
    age.keyFile = "${homeDir}/.config/sops/age/keys.txt";

    secrets = {
      ssh-key.path = "${homeDir}/.ssh/id_ed25519";
    };
  };
}
