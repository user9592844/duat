{ pkgs, lib, config, ... }:
let
  ifTheyExist = groups:
    builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  users = {
    mutableUsers = false;

    users.kiosk = {
      home = "/home/kiosk";
      isNormalUser = true;
      password = "kiosk";

      extraGroups = [ ];
      packages = [ ];

      shell = pkgs.shadow;
    };
  };

  # If this device is a kiosk, then auto-login the kiosk user
  # kiosk user should have no permissions for anything other than the web-browser
  services.displayManager.autoLogin = {
    enable = true;
    user = "kiosk";
  };
}
