{ lib, sops, ... }:

{
  imports = lib.flatten [
    sops.homeManagerModules.sops
    (lib.custom.scanPaths ./.)
  ];
}
