# TODO (user9592844): Come back and figure out how OTT restrictive I've made this
{ config, lib, ... }: {
  nix = {
    # Prevent non-root users from using nix-env, nix-build, etc.
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      #  allowed-users = [ "root" ];
      #  trusted-users = [ "root" ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };

    # # Disable user profiles (nix-env installations)
    # nixPath = lib.mkForce [ ];

    # # Disable nix-channel for all users
    # channel.enable = false;

  };

  # Disable Nix command for non-root users
  #security.sudo.extraRules = [{
  #  users = [ "ALL" ];
  #  commands = [{
  #    command = "${config.nix.package}/bin/nix-*";
  #    options = [ "NOPASSWD" "NOEXEC" ];
  #  }];
  #}];
}
