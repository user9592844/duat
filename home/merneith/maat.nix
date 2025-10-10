{ lib, ... }: {
  imports = [ ./common.nix ] ++ map lib.custom.relativeToRoot [
    "home/merneith/optional/browsers/firefox.nix"
  ];
}
