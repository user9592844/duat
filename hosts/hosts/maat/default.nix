{ lib, ... }:
let
  # Add all desired user accounts here
  users = [ "imhotep" ];
  userRelativePaths = map (user: "hosts/common/users/${user}") users;
  userAbsolutePaths = map lib.custom.relativeToRoot userRelativePaths;

  # Add all desired optional system modules here
  optionalModules = [ ];
in
{
  # Define all the users for this host
  userList.maat = users;

  imports = lib.flatten [
    ./hardware-configuration.nix
    (lib.custom.relativeToRoot "hosts/common/core")
    # (map lib.custom.relativeToRoot userPaths)
    userAbsolutePaths
    (map lib.custom.relativeToRoot optionalModules)
  ];

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        editor = false;
      };
      efi.canTouchEfiVariables = true;
    };
    initrd.systemd.enable = true;
  };

  networking = {
    hostName = "maat";
    networkmanager.enable = true;
    firewall.enable = true;
  };

  system.stateVersion = "24.11";
}
