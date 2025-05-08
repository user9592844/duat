{ inputs, config, lib, ... }:
let
  sopsDirectory = builtins.toString inputs.duat-secrets + "/sops";

  sopsSecretsList = map
    (user: {
      "keys/age/${user}" = {
        owner = user;
        inherit (config.users.users.${user}) group;
        path = "/home/${user}/.config/sops/age/keys.txt";
      };
      "passwords/${user}".neededForUsers = true;
    })
    config.userList.${config.networking.hostName};

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
    config.userList.${config.networking.hostName};
in
{
  imports = [ inputs.sops.nixosModules.sops ];

  sops = {
    defaultSopsFile = "${sopsDirectory}/${config.networking.hostName}";
    validateSopsFiles = false;

    # The host SSH key is used for decryption of the system secrets
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

    # Generate the secrets attribute set for each defined system user (defined
    # in the host default.nix, and the module for the option is in
    # modules/per-host-users.nix)

    secrets = lib.foldl' lib.mergeAttrs { } sopsSecretsList;
  };

  # Ensure the keys are owned by the user and set the user's groups
  system.activationScripts.sopsSetAgeKeyOwnership = builtins.concatStringsSep "" setAgeKeyOwnershipList;
}
