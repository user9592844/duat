final: prev:
let
  inherit (prev) lib;

  patchDirs = lib.filterAttrs (_: v: v == "directory") (builtins.readDir ./.);

  names = builtins.attrNames patchDirs;
in
builtins.listToAttrs (map
  (name: {
    inherit name;
    value = final.callPackage (./. + "/${name}") { };
  })
  names)
