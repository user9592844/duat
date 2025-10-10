{ lib, ... }: {
  imports = [
    ./common.nix
  ] ++ map lib.custom.relativeToRoot [ ];
}
