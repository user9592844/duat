{ config, lib, home-manager, ... }:
let
  # Used to allow for host-specific configurations
  isHostnameFile = builtins.pathExists (lib.custom.relativeToRoot "home/kiosk/${config.networking.hostName}.nix");
in
{
  home-manager.users.kiosk = {
    imports = lib.flatten [
      # (lib.custom.relativeToRoot "home/kiosk/core")
      (lib.optional isHostnameFile (lib.custom.relativeToRoot "home/kiosk/${config.networking.hostName}.nix"))
    ];

    home = {
      username = "kiosk";
      homeDirectory = "/home/kiosk";
      stateVersion = "24.11";
    };
  };
}
