{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;

    settings = {
      show_startup_tips = false;
      show_release_notes = false;
    };
  };
}
