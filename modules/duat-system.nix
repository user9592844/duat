{ lib, ... }:
let
  hostNames = builtins.attrNames (builtins.readDir ../hosts/hosts);
in
{
  options.duat = lib.genAttrs hostNames (host: {
    users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "List of users to configure for ${host}";
    };
    isXrdp = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether or not to enable the XRDP service for this host";
    };
    isImpermanenceAvailable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "A flag denoting whether or not impermanence is enabled";
    };
  });

  config = { };
}
