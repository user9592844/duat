{ lib, ... }:
let
  # Add all desired user accounts here
  users = [ "imhotep" ];

  # Add all desired optional system modules here
  optionalModules = [
    "hosts/common/optional/services/openssh.nix"
    "hosts/common/optional/services/tailscale.nix"
    "hosts/common/optional/services/xe-guest-utilities.nix"
    "hosts/common/optional/terminal/dig.nix"
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
    (lib.custom.relativeToRoot "hosts/hosts/osiris/services")
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
      checkReversePath = "loose";
      allowedTCPPorts = [ 22 53 853 ];
      allowedUDPPorts = [ 53 853 ];

      trustedInterfaces = [ "tailscale0" "enX1" ];

      interfaces."tailscale0" = {
        allowedTCPPorts = [ 22 53 853 ];
        allowedUDPPorts = [ 53 853 ];
      };
    };
  };

  # Remove all default packages, and only install those in this config
  environment = {
    defaultPackages = lib.mkForce [ ];
    enableAllTerminfo = true;
  };

  system.stateVersion = "25.05";
}
