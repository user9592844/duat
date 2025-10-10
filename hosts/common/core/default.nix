{ lib, sops, disko, impermanence, ... }:
{
  imports = lib.flatten [
    sops.nixosModules.sops
    impermanence.nixosModules.impermanence
    disko.nixosModules.disko
    (lib.custom.scanPaths ./.)
    (lib.custom.relativeToRoot "modules")
  ];
}
