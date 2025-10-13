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

    secrets = { };
  };
}
