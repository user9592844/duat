{
  description = "";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOs/nixos-hardware";
    disko.url = "github:nix-community/disko";
    impermanence.url = "github:nix-community/impermanence";
    home-manager.url = "github:nix-community/home-manager";
    sops.url = "github:mic92/sops-nix";

    # Private repository to hold the secrets for hosts/systems
    duat-secrets = {
      url =
        "git+ssh://git@github.com/user9592844/duat-secrets?shallow=1&ref=main";
      flake = false;
    };
  };

  outputs =
    { self
    , nixpkgs
    , nixos-hardware
    , disko
    , impermanence
    , home-manager
    , sops
    , duat-secrets
    , ...
    }@inputs:
    let
      supportedSystems =
        [ "aarch64-darwin" "aarch64-linux" "x86_64-darwin" "x86_64-linux" ];
      forEachSupportedSystem = lib.genAttrs supportedSystems;
      # Allow custom library to be under lib
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
          specialArgs = {
            inherit inputs lib nixpkgs nixos-hardware disko sops home-manager
              impermanence duat-secrets;
          };
          modules = [
            ./hosts/hosts/${host}
          ];
        });

      devShells = forEachSupportedSystem
        (system:
          let pkgs = nixpkgs.legacyPackages.${system};
          in {
            default = pkgs.mkShell {
              packages = with pkgs; [ deadnix nixpkgs-fmt mdbook nil statix just ];
            };
          });
    };
}
