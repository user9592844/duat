{ lib, ... }: {
  imports = map lib.custom.relativeToRoot [
    "home/imhotep/optional/browsers/firefox.nix"

    "home/imhotep/optional/dev/zed-editor.nix"

    "home/imhotep/optional/terminal/ghostty.nix"
  ];
}
