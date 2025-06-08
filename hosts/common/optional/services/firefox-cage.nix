{ pkgs, ... }: {
  services.cage = {
    enable = true;
    program = "${pkgs.firefox}/bin/firefox -kiosk localhost:8888";
    user = "kiosk";
  };
}
