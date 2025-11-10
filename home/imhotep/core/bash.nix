{ pkgs, ... }: {
  home.packages = with pkgs; [ bashInteractive iproute2 nmap sudo lsof ];

  programs.bash = {
    enable = true;
    enableCompletion = true;
    package = pkgs.bashInteractive;

    historySize = 10;
    historyFileSize = 0;
    historyFile = "/dev/null";

    shellAliases = {
      "cp" = "cp -i";
      "mv" = "mv -i";
      "rm" = "rm -i";

      "doas" = "sudo";

      "v" = "vim";
      "vi" = "vim";

      "cpu" = "ps -Ao pid,comm,%cpu,%mem | sort -k3 -r | head -10";
      "mem" = "ps -Ao pid,comm,%cpu,%mem | sort -k4 -r | head -10";

      "routes" = "ip route show";
      "ports" = "sudo lsof -nP -iTCP -sTCP:LIST";
      "pscan" = "nmap -T4 -F";
      "pscanfull" = "nmap -T4 -Pn -p-";
    };
  };
}
