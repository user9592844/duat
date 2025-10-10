{ lib, ... }:
{
  imports = lib.flatten [
    (lib.custom.relativeToRoot "home/imhotep/core")
  ];

  home = {
    username = "imhotep";
    homeDirectory = "/home/imhotep";
    stateVersion = "24.11";
  };

  programs.home-manager.enable = true;
}
