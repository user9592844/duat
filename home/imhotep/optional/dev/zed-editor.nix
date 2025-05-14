{
  programs.zed-editor = {
    enable = true;

    extensions =
      [ "nix" "toml" "make" "html" "terraform" "latex" "zig" "fish" ];

    userSettings = {
      auto_update = false;

      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      projects_online_by_default = false;

      theme = {
        mode = "system";
        light = "One Light";
        dark = "Catppuccin Mocha";
      };

      vim_mode = true;
      ui_font_size = 16;
      ui_font_family = "FiraCode Nerd Font Mono";
      buffer_font_size = 13;
      buffer_font_family = "FiraCode Nerd Font Mono";
      hour_format = "hour24";
      load_direnv = "shell_hook";

      assistant = {
        enabled = true;
        version = "2";

        default_open_ai_model = null;
        default_model = {
          provider = "ollama";
          model = "gemma3:1b";
        };
      };

      language_models = {
        ollama = {
          available_models = [
            {
              name = "gemma3:1b";
              max_tokens = 5000;
            }
            {
              name = "deepseek-r1:1.5b";
              max_tokens = 5000;
            }
          ];
        };
      };

      lsp = {
        rust-analyzer = { binary = { path_lookup = true; }; };

        nix = { binary = { path_lookup = true; }; };
      };
    };
  };
}
