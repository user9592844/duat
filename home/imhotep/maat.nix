{ lib, sops, config, ... }: {
  imports = [
    ./common.nix
  ] ++ map lib.custom.relativeToRoot [
    "home/imhotep/optional/browsers/firefox.nix"

    "home/imhotep/optional/dev/zed-editor.nix"

    "home/imhotep/optional/terminal/ghostty.nix"
    "home/imhotep/optional/terminal/bottom.nix"
  ];

  # These secrets are only desired on maat
  sops = {
    secrets = {
      "ssh/private_9673d1" = {
        path = "${config.home.homeDirectory}/.ssh/config.d/private.9673d1";
        mode = "0400";
      };

      "ssh/id_ed25519_9673d1" = {
        path = "${config.home.homeDirectory}/.ssh/id_ed25519_9673d1";
        mode = "0600";
      };

      "ssh/id_ed25519_99cd21" = {
        path = "${config.home.homeDirectory}/.ssh/id_ed25519_99cd21";
        mode = "0600";
      };
    };
  };
}
