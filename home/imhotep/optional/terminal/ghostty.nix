{
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      theme = "ono-sendai";
      background-opacity = 0.8;
      background-blur-radius = 20;

      font-family = "IBM Plex Mono";
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
    themes = {
      eva01 = {
        background = "#1a1026";
        foreground = "#e4e7ed";
        palette = [
          "0=#0f0f12"
          "1=#d14545"
          "2=#8be324"
          "3=#ffd242"
          "4=#6f7de2"
          "5=#b877d9"
          "6=#4be2d2"
          "7=#c7c9d1"
          "8=#2e2e32"
          "9=#ff5c5c"
          "10=#a9ff38"
          "11=#ffe970"
          "12=#8ea5ff"
          "13=#d59eff"
          "14=#6fffe0"
          "15=#f2f4f8"
        ];
      };
      ono-sendai = {
        background = "#0c0e10";
        foreground = "#e0e6f0";

        cursor-color = "#00ffd1";
        selection-background = "#1e2a33";
        selection-foreground = "#ffffff";

        palette = [
          "0=#121417"
          "1=#ff4c4c"
          "2=#33ff99"
          "3=#ffd95c"
          "4=#4cc3ff"
          "5=#ff66ff"
          "6=#00ffd1"
          "7=#e0e6f0"
          "8=#2a2d32"
          "9=#ff6666"
          "10=#66ffb2"
          "11=#ffe680"
          "12=#66ccff"
          "13=#ff80ff"
          "14=#33ffe0"
          "15=#ffffff"
        ];

        bold-is-bright = true;
      };
    };
  };
}
