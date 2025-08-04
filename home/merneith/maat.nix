{ lib, ... }: {
  imports = map lib.custom.relativeToRoot [
    "home/merneith/optional/browsers/firefox.nix"
  ];
}
