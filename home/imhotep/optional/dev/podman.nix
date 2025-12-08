{ pkgs, ... }: {
  home.packages = [ pkgs.podman-tui ];

  services.podman = {
    enable = true;
  };
}
