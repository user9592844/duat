{ config, lib, sops, duat-secrets, ... }:
let
  sopsDirectory = builtins.toString duat-secrets;

  # Grab passwords for all users on the current host
  userPasswords = map
    (username: {
      "passwords/${username}".neededForUsers = true;
    })
    config.duat.${config.networking.hostName}.users;
in
{
  sops = {
    defaultSopsFile = "${sopsDirectory}/secrets.yaml";
    validateSopsFiles = false;

    # The host SSH key is used for decryption of the system secrets
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

    secrets = lib.foldl' lib.mergeAttrs { } userPasswords;
  };
}
