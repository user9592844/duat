{ lib, home-manager, sops, ... }:

{
  imports = lib.flatten [
    home-manager.nixosModules.home-manager
    sops.nixosModules.sops
    (lib.custom.scanPaths ./.)
    (lib.custom.relativeToRoot "modules")
  ];
}
