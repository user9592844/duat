{ duat-secrets, sops, config, ... }:
let
  secretsDirectory = builtins.toString duat-secrets;
  secretsFile = "${secretsDirectory}/users/imhotep.yaml";
in
{
  sops = {
    age.sshKeyPaths = [ "/home/imhotep/.ssh/id_ed25519" ];

    defaultSopsFile = "${secretsFile}";
    validateSopsFiles = false;

    secrets = {
      "ssh/private_9673d1" = {
        path = "${config.home.homeDirectory}/.ssh/config.d/private.9673d1";
        mode = "0400";
      };

      "ssh/id_ed25519_9673d1" = {
        path = "${config.home.homeDirectory}/.ssh/id_ed25519_9673d1";
        mode = "0600";
      };

      "ssh/id_ed25519_99cd21" = {
        path = "${config.home.homeDirectory}/.ssh/id_ed25519_99cd21";
        mode = "0600";
      };
    };
  };
}
