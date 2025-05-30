{ pkgs, lib, config, sops ? null, ... }:
let
  ifTheyExist = groups:
    builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  users = {
    mutableUsers = false;

    users.imhotep = {
      home = "/home/imhotep";
      isNormalUser = true;
      hashedPasswordFile = config.sops.secrets."passwords/imhotep".path;
      hashedPassword =
        "$y$j9T$7YfXBuolEsCTZP.myXOMT/$T5lK.oS1CAwRQhQGKqmJaEtp2y9h2XtMxnMijm4pRw3";
      # hashedPassword =
      #   "$y$j9T$yh0.AEB8.JPcZTaXmCD8c1$UrSCgC9BNeVBZaqsWDAV7nMtGA1kISbKwFzk1/y3.U4";

      extraGroups = [ "wheel" ] ++ ifTheyExist [
        "audio"
        "video"
        "docker"
        "disk"
        "git"
        "networkmanager"
        "cdrom"
      ];

      shell = pkgs.fish;
    };
  };

  environment.persistence."/persist" = {
    users.imhotep = {
      directories = [
        "Configurations"
        "Desktop"
        "Documents"
        "Downloads"
        "Music"
        "Pictures"
        "Public"
        "Templates"
        "Videos"
        "Workspace"
        ".local/share/direnv"
        {
          directory = ".ssh";
          mode = "0700";
        }
        {
          directory = ".local/share/keyring";
          mode = "0700";
        }
      ];
    };
  };

  # Ensure Git and Fish are always available for this user
  programs.fish.enable = true;
  programs.git.enable = true;
}
