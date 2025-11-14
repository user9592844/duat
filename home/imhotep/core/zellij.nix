{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;

    settings = {
      show_startup_tips = false;
      show_release_notes = false;
      default_layout = "default-session";
    };
  };

  home.file.".config/zellij/layouts/default-session.kdl".text = ''
    layout {
        tab name="bottom" hide_floating_panes=true {
            pane size=1 borderless=true {
                plugin location="zellij:tab-bar"
            }
            pane command="btm" {
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
}
