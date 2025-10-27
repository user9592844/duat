{ config, sops, duat-secrets, ... }:
let
  sopsDirectory = builtins.toString duat-secrets;
in
{
  # Deploy sensitive data
  sops.secrets = {
    "unbound" = {
      sopsFile = "${sopsDirectory}/secrets.yaml";
    };
  };

  services.unbound = {
    enable = true;
    settings = {
      # Include must be used since Sops are files at runtime, not evaluation time
      include = config.sops.secrets."unbound".path;
    };
  };
}
