{ lib, ... }:
let
  # Add all desired user accounts here
  users = [ "imhotep" "merneith" ];

  # Add all desired optional system modules here
  optionalModules = [
    "hosts/common/optional/browser/firefox.nix"
    "hosts/common/optional/desktop/cosmic-desktop.nix"
    "hosts/common/optional/desktop/libreoffice.nix"
    "hosts/common/optional/desktop/proton-pass.nix"
    "hosts/common/optional/desktop/protonmail-desktop.nix"
    "hosts/common/optional/desktop/protonvpn-gui.nix"
  ];

  # Grab the path to the user system config
  userRelativePaths = map (user: "hosts/common/users/${user}") users;
  userAbsolutePaths = map lib.custom.relativeToRoot userRelativePaths;
in
{
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  imports = lib.flatten [
    # ./hardware-configuration.nix
    (lib.custom.relativeToRoot "hosts/common/disks/ext4.nix")
    (lib.custom.relativeToRoot "hosts/common/core")
    userAbsolutePaths
    (map lib.custom.relativeToRoot optionalModules)
  ];

  duat.bastet.users = users;

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        editor = false;
      };
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "bastet";
    networkmanager.enable = true;
    firewall.enable = true;
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
