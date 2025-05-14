{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "user9592844";
    userEmail = "139545179+user9592844@users.noreply.github.com";
    aliases = { };
    extraConfig = {
      init.defaultBranch = "main";
      url = {
        "ssh://git@github.com" = { insteadOf = "https://github.com"; };
        "ssh://git@gitlab.com" = { insteadOf = "https://gitlab.com"; };
      };
      # signing = {
      #   signByDefault = true;
      #   key = publicKey;
      # };
    };
    ignores = [ ".direnv" "result" ];
  };
}
