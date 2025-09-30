{ pkgs, ... }: {
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    ibm-plex
    fira-code
    fira-mono
    fira-code-symbols
    nerd-fonts.fira-code
  ];
}
