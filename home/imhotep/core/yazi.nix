{ config, pkgs, lib, ... }:
let
  yazi-plugins = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "main";
    sha256 = "sha256-ZCLJ6BjMAj64/zM606qxnmzl2la4dvO/F5QFicBEYfU=";
  };
in
{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      mgr = {
        show-hidden = true;
        ratio = [ 1 4 3 ];
      };
    };

    plugins = {
      git = "${yazi-plugins}/git.yazi";
    };

    initLua = ''
      require("git"):setup()
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
                    args "YAZI_CONFIG_HOME=~/.config/yazelix/yazi" "yazi"
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
