{
  description = "";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    nixos-hardware.url = "github:NixOs/nixos-hardware";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
      # Allow custom library to be under lib
      lib = nixpkgs.lib.extend
        (self: super: { custom = import ./lib { inherit (nixpkgs) lib; }; inherit (home-manager.lib) hm; });
      forEachSupportedSystem = lib.genAttrs
        [ "aarch64-darwin" "aarch64-linux" "x86_64-darwin" "x86_64-linux" ];
      hostList =
        builtins.attrNames (builtins.readDir ./hosts/hosts);
      userList =
        builtins.attrNames (builtins.readDir ./home);
      forEachHost = lib.genAttrs hostList;
      forEachUserHost = lib.genAttrs (builtins.concatMap (user: map (hostname: "${user}@${hostname}") hostList) userList);
    in
    {
      # For each host in ./hosts/hosts create a nixosConfiguration
      # NOTE: Only the currently requested hostname will be built
      nixosConfigurations = forEachHost (host:
        let

          pkgs = import nixpkgs {
            system = "x86_64-linux";
            overlays = [ (import ./pkgs/patches) ];
          };
        in
        lib.nixosSystem {
          inherit pkgs;
          specialArgs = {
            inherit inputs lib nixos-hardware disko sops
              impermanence duat-secrets;
          };
          modules = [
            ./hosts/hosts/${host}
          ];
        });

      # For each user in ./home create a homeConfiguration
      # NOTE: Only the currently requested user will be built
      homeConfigurations = forEachUserHost
        (userHost:
          let
            # Hostname is element two becaues empties are interleaved in the list
            parts = builtins.split "[@]" userHost;
            user = builtins.elemAt parts 0;
            host = builtins.elemAt parts 2;
          in
          home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages."x86_64-linux";
            modules = [ ./home/${user}/${host}.nix ];
            extraSpecialArgs = { inherit inputs lib sops impermanence duat-secrets; };
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
