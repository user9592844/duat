{ pkgs, config, lib, ... }:
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

      extraGroups = [ "wheel" ] ++ ifTheyExist [
        "audio"
        "video"
        "docker"
        "disk"
        "git"
        "networkmanager"
        "cdrom"
        "plugdev"
        "vboxusers"
      ];

      shell = pkgs.fish;
    };
  };

  environment.persistence."/persist" = lib.mkIf (config.duat.${config.networking.hostName}.isImpermanenceAvailable) {
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
