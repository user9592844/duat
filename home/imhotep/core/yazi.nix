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
      ];
    };

    plugins = {
      git = pkgs.yaziPlugins.git;
      lazygit = pkgs.yaziPlugins.lazygit;
      starship = pkgs.yaziPlugins.starship;
    };

    initLua = ''
      require("git"):setup()
      require("starship"):setup()
    '';
  };

  # If Zellij is enabled, then set Yazi as the layout and default_layout
  home.file.".config/zellij/layouts/yazi.kdl".text = lib.mkIf config.programs.zellij.enable ''
      layout {
        tab_template name="ui" {
            pane size=1 borderless=true {
               plugin location="zellij:tab-bar"
            }
            children
            pane size=1 borderless=true {
               plugin location="zellij:status-bar"
            }
        }

        default_tab_template {
            pane size=1 borderless=true {
               plugin location="zellij:tab-bar"
            }
            pane split_direction="vertical" {
                pane name="sidebar" {
                    command "env"
                    args "YAZI_CONFIG_HOME=~/.config/yazi/" "yazi"
                	size "100%"
                }
            }
            pane size=1 borderless=true {
               plugin location="zellij:status-bar"
            }
        }
    }
  '';

  programs.zellij.settings.default_layout = lib.mkIf config.programs.zellij.enable "yazi";
}
