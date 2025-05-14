{ config, lib, home-manager, ... }:
let
  # Used to allow for host-specific configurations
  isHostnameFile = builtins.pathExists (lib.custom.relativeToRoot "home/imhotep/${config.networking.hostName}.nix");
in
{
  home-manager.users.imhotep = {
    imports = lib.flatten [
      (lib.custom.relativeToRoot "home/imhotep/core")
      (lib.optional isHostnameFile (lib.custom.relativeToRoot "home/imhotep/${config.networking.hostName}.nix"))
    ];

    home = {
      username = "imhotep";
      homeDirectory = "/home/imhotep";
      stateVersion = "24.11";
    };
  };
}
