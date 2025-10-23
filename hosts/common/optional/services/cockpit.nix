{ lib, pkgs, config, ... }:
let
  cockpit-podman = pkgs.callPackage (lib.custom.relativeToRoot "pkgs/patches/cockpit-podman") { };
in
{
  # Enable cockpit for local only HTTP access
  services.cockpit = {
    enable = true;
    openFirewall = false;

    settings.WebService = {
      AllowUnencrypted = lib.mkForce true;
      Origins = lib.mkForce "http://127.0.0.1:9090 http://localhost:9090";
    };
  };

  # Override specific attributes for specific use-case of local only access
  systemd.sockets.cockpit.socketConfig = {
    Backlog = 64;
    BindToDevice = "lo";
  };

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  # Add podman-compose for Docker Compose functionality, and add cockpit-podman plugin
  environment.systemPackages = [ pkgs.podman-compose pkgs.slirp4netns pkgs.fuse-overlayfs cockpit-podman ];
}
