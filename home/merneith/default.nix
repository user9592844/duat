{ config, lib, home-manager, ... }:
let
  # Used to allow for host-specific configurations
  isHostnameFile = builtins.pathExists (lib.custom.relativeToRoot "home/merneith/${config.networking.hostName}.nix");
in
{
  home-manager.users.merneith = {
    imports = lib.flatten [
      (lib.custom.relativeToRoot "home/merneith/core")
      (lib.optional isHostnameFile (lib.custom.relativeToRoot "home/merneith/${config.networking.hostName}.nix"))
    ];

    home = {
      username = "merneith";
      homeDirectory = "/home/merneith";
      stateVersion = "24.11";
    };
  };
}
