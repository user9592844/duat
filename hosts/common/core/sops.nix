{ config, lib, sops, duat-secrets, ... }:
let
  sopsDirectory = builtins.toString duat-secrets;

  sopsSecretsList = map
    (user: {
      # Allow user-specific secrets to be decoded by these keys
      "keys/age/${user}" = {
        owner = user;
        inherit (config.users.users.${user}) group;
        path = "/home/${user}/.config/sops/age/keys.txt";
      };
      "passwords/${user}".neededForUsers = true;
    })
    config.duat.${config.networking.hostName}.users;

  setAgeKeyOwnershipList = map
    (username:
      let
        ageFolder = "/home/${username}/.config/sops/age";
        inherit (config.users.users.${username}) group;
      in
      ''
        mkdir -p ${ageFolder} || true
        chown -R ${username}:${group} /home/${username}/.config
      '')
    config.duat.${config.networking.hostName}.users;
in
{
  imports = [ sops.nixosModules.sops ];

  sops = {
    defaultSopsFile = "${sopsDirectory}/secrets.yaml";
    validateSopsFiles = false;

    # The host SSH key is used for decryption of the system secrets
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

    # Generate the secrets attribute set for each defined system user (defined
    # in the host default.nix, and the module for the option is in
    # modules/per-host-users.nix)

    secrets = lib.foldl' lib.mergeAttrs { } sopsSecretsList;
  };

  # Ensure the keys are owned by the user and set the user's groups
  system.activationScripts.sopsSetAgeKeyOwnership =
    builtins.concatStringsSep "" setAgeKeyOwnershipList;
}
