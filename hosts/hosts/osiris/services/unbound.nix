{ config, sops, duat-secrets, lib, ... }:
let
  sopsDirectory = builtins.toString duat-secrets;
in
{
  # Deploy sensitive data
  sops.secrets = {
    "unbound" = {
      sopsFile = "${sopsDirectory}/secrets.yaml";
      owner = "unbound";
      group = "unbound";
      mode = "0400";
    };
  };

  services.unbound.enable = true;

  environment.etc."unbound/unbound.conf".source = lib.mkForce config.sops.secrets."unbound".path;

  # Allow the ports to be opened
  networking.firewall = {
    allowedTCPPorts = [ 53 853 ];
    allowedUDPPorts = [ 53 853 ];
  };
}
