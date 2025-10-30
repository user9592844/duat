{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;

    settings = {
      user = {
        name = "user9592844";
        email = "139545179+user9592844@users.noreply.github.com";
      };
      aliases = { };
      init.defaultBranch = "main";
      url = {
        "ssh://git@github.com" = { insteadOf = "https://github.com"; };
        "ssh://git@gitlab.com" = { insteadOf = "https://gitlab.com"; };
      };
    };

    ignores = [ ".direnv" "result" ];
  };
}
