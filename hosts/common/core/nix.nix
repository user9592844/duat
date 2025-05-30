{
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

  };
}
