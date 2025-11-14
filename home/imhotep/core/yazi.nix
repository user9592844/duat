{ pkgs, ... }: {
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
}
