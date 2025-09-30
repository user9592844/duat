{ config, pkgs, lib, ... }: {
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      mgr = {
        show_hidden = true;
        ratio = [ 1 4 3 ];
      };
      plugin = {
        prepend_fetchers = [
          {
            id = "git";
            name = "*";
            run = "git";
          }
          {
            id = "git";
            name = "*/";
            run = "git";
          }
        ];
      };
    };

    keymap = {
      manager.prepend_keymap = [
        {
          on = [ "g" "i" ];
          run = "plugin lazygit";
          desc = "run lazygit";
        }
        {
          on = [ "c" "m" ];
          run = "plugin chmod";
          desc = "Chmod on selected files";
        }
      ];
    };

    plugins = {
      inherit (pkgs.yaziPlugins) chmod git lazygit starship;
    };

    initLua = ''
      require("git"):setup()
      require("starship"):setup()
    '';
  };

  # If Zellij is enabled, then set Yazi as the layout and default_layout
  home.file.".config/zellij/layouts/yazi.kdl".text = lib.mkIf
    config.programs.zellij.enable
    ''
      layout {
          tab name="btop" hide_floating_panes=true {
              pane size=1 borderless=true {
                  plugin location="zellij:tab-bar"
              }
              pane command="btop" {
                  start_suspended false
              }
              pane size=1 borderless=true {
                  plugin location="zellij:status-bar"
              }
          }
          tab name="localhost" focus=true {
              pane size=1 borderless=true {
                  plugin location="zellij:tab-bar"
              }
              pane name="sidebar" {
                  command "env"
                  args "YAZI_CONFIG_HOME=~/.config/yazi" "yazi"
              }
              pane size=1 borderless=true {
                  plugin location="zellij:status-bar"
              }
          }
          new_tab_template {
              pane size=1 borderless=true {
                  plugin location="zellij:tab-bar"
              }
              pane split_direction="vertical" {
                  pane command="env" name="sidebar" size="100%" {
                      args "YAZI_CONFIG_HOME=~/.config/yazi/" "yazi"
                      start_suspended true
                  }
              }
              pane size=1 borderless=true {
                  plugin location="zellij:status-bar"
              }
              floating_panes {
                  pane {
                  }
              }
          }
      }
    '';

  programs.zellij.settings.default_layout = lib.mkIf
    config.programs.zellij.enable
    "yazi";
}
