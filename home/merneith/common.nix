{ lib, ... }:
{
  imports = lib.flatten [
    (lib.custom.relativeToRoot "home/merneith/core")
  ];

  home = {
    username = "merneith";
    homeDirectory = "/home/merneith";
    stateVersion = "24.11";
  };

  programs.home-manager.enable = true;
}
