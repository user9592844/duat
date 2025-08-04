{ pkgs, config, lib, ... }:
let
  ifTheyExist = groups:
    builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  users = {
    mutableUsers = false;

    users.merneith = {
      home = "/home/merneith";
      isNormalUser = true;
      hashedPasswordFile = config.sops.secrets."passwords/merneith".path;
      hashedPassword =
        "$y$j9T$QAfKIVbN/1TB2CkvS0MfB1$N76UOkIFz4BLmqRwcJvNKnn5PqMV/dvHxOCLccKdvv.";

      extraGroups = [ ] ++ ifTheyExist [
        "audio"
        "video"
      ];

      shell = pkgs.fish;
    };
  };

  # environment.persistence."/persist" = lib.mkIf (config.environment.persistence."/persist".enable) {
  #   users.merneith = {
  #     directories = [
  #       "Configurations"
  #       "Desktop"
  #       "Documents"
  #       "Downloads"
  #       "Music"
  #       "Pictures"
  #       "Public"
  #       "Templates"
  #       "Videos"
  #       "Workspace"
  #       ".local/share/direnv"
  #       {
  #         directory = ".ssh";
  #         mode = "0700";
  #       }
  #       {
  #         directory = ".local/share/keyring";
  #         mode = "0700";
  #       }
  #     ];
  #   };
  # };

  # Ensure Git and Fish are always available for this user
  programs.fish.enable = true;
}
