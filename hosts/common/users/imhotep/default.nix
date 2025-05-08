{ inputs, pkgs, lib, config, ... }:
let
  ifTheyExist = groups:
    builtins.filter (group: builtins.hasAttr group config.users.groups) groups;

  sopsHashedPasswordFile = lib.optionalString (lib.hasAttr "sops-nix" inputs)
    config.sops.secrets."imhotep/password".path;
in
{
  users = {
    mutableUsers = false;

    users.imhotep = {
      home = "/home/imhotep";
      isNormalUser = true;
      hashedPasswordFile = lib.mkIf (sopsHashedPasswordFile != "") sopsHashedPasswordFile;
      hashedPassword = "$y$j9T$7YfXBuolEsCTZP.myXOMT/$T5lK.oS1CAwRQhQGKqmJaEtp2y9h2XtMxnMijm4pRw3";

      extraGroups = [
        "wheel"
      ] ++ ifTheyExist [
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

  # Ensure Git and Fish are always available for this user
  programs.fish.enable = true;
  programs.git.enable = true;
}
