# Description: Read the names of all direcotires in ../hosts/hosts and create
#              an option for config.${hostName}.userList which stores a list
#              of strings (the usernames to be included in the configuration)
{ lib, ... }:
let
  hostNames = builtins.attrNames (builtins.readDir ../hosts/hosts);
in
{
  options.userList = lib.genAttrs hostNames (host: lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ ];
    description = "List of users for ${host}";
  });

  config = { };
}
