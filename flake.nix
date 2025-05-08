{
  description = "";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    disko.url = "github:nix-community/disko";
    home-manager.url = "github:nix-community/home-manager";
    sops.url = "github:mic92/sops-nix";
    duat-secrets = {
      url = "git+ssh://git@github.com/user9592844/duat-secrets?shallow=1&ref=main";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, disko, home-manager, sops, duat-secrets, ... }@inputs:
    let
      lib = nixpkgs.lib.extend
        (self: super: { custom = import ./lib { inherit (nixpkgs) lib; }; });
      forEachHost =
        lib.genAttrs (builtins.attrNames (builtins.readDir ./hosts/hosts));
    in
    {
      # For each host in ./hosts/hosts create a nixosConfiguration
      # NOTE: Only the currently requested hostname will be built
      nixosConfigurations = forEachHost (host:
        lib.nixosSystem {
          specialArgs = { inherit inputs lib disko sops home-manager; };
          modules = [ ./hosts/hosts/${host} ];
        });
    };
}
