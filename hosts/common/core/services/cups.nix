{ lib, ... }: {
  systemd.services.cups = {
    # Service shouldn't currently be used, therefore set the default to false
    enable = lib.mkDefault false;

    # If it's needed at a later date, re-enable with these configs
    serviceConfig = {
      NoNewPrivileges = true;
      ProtectSystem = "full";
      ProtectHome = true;
      ProtectKernelModules = true;
      ProtectKernelTunables = true;
      ProtectKernelLogs = true;
      ProtectControlGroups = true;
      ProtectHostname = true;
      ProtectClock = true;
      ProtectProc = "invisible";
      RestrictRealtime = true;
      RestrictNamespaces = true;
      RestrictSUIDSGID = true;
      RestrictAddressFamilies = [
        "AF_UNIX"
        "AF_NETLINK"
        "AF_INET"
        "AF_INET6"
        "AF_PACKET"
      ];

      MemoryDenyWriteExecute = true;
      SystemCallFilter = [
        "~@clock"
        "~@reboot"
        "~@debug"
        "~@module"
        "~@swap"
        "~@obsolete"
        "~@cpu-emulation"
      ];
      SystemCallArchitectures = "native";
      LockPersonality = true;
    };
  };
}
