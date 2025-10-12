{ pkgs, lib, ... }:
let cockpit-podman = pkgs.callPackage (lib.custom.relativeToRoot "pkgs/cockpit-podman") { };
in {
  # This won't work without Podman
  virtualisation.podman.enable = true;

  # Adding the plugin to systemPackages will get picked up by Cockpit
  environment.systemPackages = [ cockpit-podman ];
}
