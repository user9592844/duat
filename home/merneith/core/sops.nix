{ duat-secrets, sops, ... }:
let
  secretsDirectory = builtins.toString duat-secrets;
  secretsFile = "${secretsDirectory}/users/merneith.yaml";
in
{
  sops = {
    age.keyFile = "/home/merneith/.config/sops/age/keys.txt";

    defaultSopsFile = "${secretsFile}";
    validateSopsFiles = false;

    # TODO (user9592844): Populate with user secrets
    secrets = { };
  };
}
