{ lib, ... }:
let
  # Add all desired user accounts
  users = [ "imhotep" ];

  # Add all desired optional system modules
  optionalModules = [ ];

  # Grab the path to the user system config and home-manager config
  userRelativePaths = map (user: "hosts/common/users/${user}") users;
  homeRelativePaths = map (user: "home/${user}") users;
  userAbsolutePaths = map lib.custom.relativeToRoot userRelativePaths;
  homeAbsolutePaths = map lib.custom.relativeToRoot homeRelativePaths;
in
{

  imports = lib.flatten [
    ./hardware-configuration.nix
    (lib.custom.relativeToRoot "hosts/common/disks/zfs-impermanence.nix")
    (lib.custom.relativeToRoot "hosts/common/core")
    userAbsolutePaths
    homeAbsolutePaths
    (map lib.custom.relativeToRoot optionalModules)
  ];

  duat.anubis.users = users;

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
    hostName = "anubis";
    wireless.enable = lib.mkForce false;
    interfaces.eth0.useDHCP = false;

    # Public services VLAN (exposed to tailnet)
    vlans.duaj = {
      interface = "eth0";
      id = 40;
    };

    # Administration VLAN
    vlans.sefe = {
      interface = "eth0";
      id = 50;
    };

    nftables = {
      enable = true;

      ruleset = ''
        table inet filter {
          chain input {
            type filter hook input priority 0;
            policy drop;

            iif lo accept
            ct state established, related accept

            # Allow SSH only from VLAN10
            iifname "eth0.40" tcp dport 22 accept
          }

          chain forward {
            type filter hook forward priority 0;
            policy drop;

            iifname "eth0.50" oifname "tailscale0" accept
            iifname "tailscale0" oifname "eth0.50" accept

            ct state established,related accept
          }

          chain output {
            type filter hook output priority 0;
            policy accept;
          }
        }

        table ip nat {
          chain postrouting {
            type nat hook postrouting priority 100;
            oifname "tailscale0" ip saddr 10.1.50.0/24
          }
        }
      '';
    };
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
