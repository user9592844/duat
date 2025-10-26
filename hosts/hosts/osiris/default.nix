{ lib, ... }:
let
  # Add all desired user accounts here
  users = [ "imhotep" ];

  # Add all desired optional system modules here
  optionalModules = [
    "hosts/common/optional/services/openssh.nix"
    "hosts/common/optional/services/tailscale.nix"
    "hosts/common/optional/services/xe-guest-utilities.nix"
  ];

  # Grab the path to the user system config
  userRelativePaths = map (user: "hosts/common/users/${user}") users;
  userAbsolutePaths = map lib.custom.relativeToRoot userRelativePaths;
in
{
  imports = lib.flatten [
    ./hardware-configuration.nix
    (lib.custom.relativeToRoot "hosts/common/core")
    userAbsolutePaths
    (map lib.custom.relativeToRoot optionalModules)
  ];

  duat.osiris.users = users;

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "osiris";
    useDHCP = true;

    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 53 ];
      allowedUDPPorts = [ 53 ];
    };
  };

  # Remove all default packages, and only install those in this config
  environment.defaultPackages = lib.mkForce [ ];

  system.stateVersion = "25.05";
}
