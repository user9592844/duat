{ nixos-hardware, lib, ... }:
let
  # Add all desired user accounts here
  users = [ "kiosk" ];

  # Add all desired optional system modules here
  optionalModules = [
    "hosts/common/optional/browser/firefox.nix"
    "hosts/common/optional/services/firefox-cage.nix"
  ];

  # Grab the path to the user system config and home-manager config
  userRelativePaths = map (user: "hosts/common/users/${user}") users;
  homeRelativePaths = map (user: "home/${user}") users;
  userAbsolutePaths = map lib.custom.relativeToRoot userRelativePaths;
  homeAbsolutePaths = map lib.custom.relativeToRoot homeRelativePaths;
in
{
  imports = lib.flatten [
    ./hardware-configuration.nix
    (lib.custom.relativeToRoot "hosts/common/core")
    userAbsolutePaths
    homeAbsolutePaths
    (map lib.custom.relativeToRoot optionalModules)
  ];

  duat.kiosk.users = users;
  users.allowNoPasswordLogin = true;

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        editor = false;
      };
      efi.canTouchEfiVariables = true;
    };
    initrd.includeDefaultModules = false;
  };

  documentation = {
    doc.enable = false;
    info.enable = false;
    man.enable = false;
    nixos.enable = false;
  };

  services.openssh.enable = true;

  networking = {
    # TODO (user9592844): Come up with a way to have one kiosk config that generates different kiosk hostNames with no collision
    hostName = "kiosk";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 ];
    };
    wireless.enable = false;
  };

  security = {
    auditd.enable = true;
    audit = {
      enable = true;
      rules = [ "-a exit,always -F arch=b64 -S execve" ];
    };
    sudo.execWheelOnly = true;
  };

  # Remove all default packages, and only install those in this config
  environment.defaultPackages = lib.mkForce [ ];

  system.stateVersion = "24.11";
}
