{
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      background-opacity = 0.8;
      background-blur-radius = 20;

      font-family = "FiraCode Nerd Font Mono";
      font-size = 13;
      font-feature = "-liga";

      keybind = [ "global:ctrl+grave_accent=toggle_quick_terminal" ];

      clipboard-paste-protection = true;
      # clipboard-trim-tailing-spaces = true;
      copy-on-select = true;
      link-url = true;
      shell-integration-features = true;
      shell-integration = "fish";
      clipboard-write = "ask";
      clipboard-read = "deny";
    };
  };
}
