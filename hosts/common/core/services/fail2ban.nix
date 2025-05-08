{ lib, ... }:
{
  services.fail2ban = lib.mkForce {
    enable = true;
    jails = {
      sshd = ''
        enabled = true
        maxretry = 3
        findtime = 1h
        bantime = 24h
      '';
    };
  };
}
