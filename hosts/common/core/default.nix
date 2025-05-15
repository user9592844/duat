{ lib, home-manager, sops, disko, impermanence, ... }:

{
  imports = lib.flatten [
    home-manager.nixosModules.home-manager
    {
      home-manager.extraSpecialArgs = { inherit sops impermanence; };
    } # Expose inputs to home-manager as needed
    sops.nixosModules.sops
    impermanence.nixosModules.impermanence
    disko.nixosModules.disko
    (lib.custom.scanPaths ./.)
    (lib.custom.relativeToRoot "modules")
  ];

  home-manager.backupFileExtension = "backup";
}
