{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    extraConfig = ''
      TCPKeepAlive yes
    '';

    includes = [
      "~/.ssh/config.d/private.9673d1"
    ];

    matchBlocks = {
      # Global configurations
      "*" = {
        serverAliveInterval = 60;
        serverAliveCountMax = 5;
        controlMaster = "auto";
        controlPath = "~/.ssh/cm-%C";
        controlPersist = "1h";
      };

      "github.com" = {
        hostname = "github.com";
        user = "imhotep";
        identityFile = "~/.ssh/id_ed25519_99cd21";
      };
    };
  };
}
