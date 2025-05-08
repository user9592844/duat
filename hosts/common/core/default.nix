{ inputs, lib, ... }:

{
  imports = lib.flatten [
    inputs.home-manager.nixosModules.home-manager
    inputs.sops.nixosModules.sops
    (lib.custom.scanPaths ./.)
    (lib.custom.relativeToRoot "modules")
  ];
}
