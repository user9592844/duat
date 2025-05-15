{
  environment.persistence."/persist" = {
    enable = true;
    hideMounts = true;

    directories = [
      "/etc/NetworkManager/system-connections"
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
    ];
    files = [
      # "/etc/machine-id"
      # "/etc/ssh/ssh_host_ed25519_key"
      # "/etc/ssh/ssh_host_ed25519_key.pub"
    ];
  };
}
