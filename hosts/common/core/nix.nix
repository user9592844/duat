{ config, lib, ... }: {
  nix = {
    # Prevent non-root users from using nix-env, nix-build, etc.
    settings = {
      allowed-users = [ "root" ];
      trusted-users = [ "root" ];
    };

    # Disable user profiles (nix-env installations)
    nixPath = lib.mkForce [ ];

    # Disable nix-channel for all users
    channel.enable = false;

  };

  # Disable Nix command for non-root users
  security.sudo.extraRules = [{
    users = [ "ALL" ];
    commands = [{
      command = "${config.nix.package}/bin/nix-*";
      options = [ "NOPASSWD" "NOEXEC" ];
    }];
  }];
}
