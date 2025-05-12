{ lib, ... }: {
  imports = map lib.custom.relativeToRoot [
    "home/imhotep/common/optional/dev/zed-editor.nix"

    "home/imhotep/common/optional/terminal/ghostty.nix"
    "home/imhotep/common/optional/terminal/zellij.nix"
  ];
}
