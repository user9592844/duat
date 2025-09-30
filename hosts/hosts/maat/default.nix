{ nixos-hardware, lib, ... }:
let
  # Add all desired user accounts here
  users = [ "imhotep" ];

  # Add all desired optional system modules here
  optionalModules = [
    "hosts/common/optional/browser/firefox.nix"
    "hosts/common/optional/desktop/bitwarden-desktop.nix"
    "hosts/common/optional/desktop/cosmic-desktop.nix"
    "hosts/common/optional/desktop/keepassxc.nix"
    "hosts/common/optional/desktop/ledger-live-desktop.nix"
    "hosts/common/optional/desktop/libreoffice.nix"
    "hosts/common/optional/desktop/protonmail-desktop.nix"
    "hosts/common/optional/desktop/proton-pass.nix"
    "hosts/common/optional/desktop/protonvpn-gui.nix"
    "hosts/common/optional/desktop/virtualbox.nix"
    "hosts/common/optional/services/impermanence.nix"
    "hosts/common/optional/services/tailscale.nix"
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
    (lib.custom.relativeToRoot "hosts/common/disks/luks-btrfs-impermanence.nix")
    (lib.custom.relativeToRoot "hosts/common/core")
    userAbsolutePaths
    homeAbsolutePaths
    (map lib.custom.relativeToRoot optionalModules)
    nixos-hardware.nixosModules.lenovo-thinkpad-t480s
  ];

  duat.maat.users = users;

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
    hostName = "maat";
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
