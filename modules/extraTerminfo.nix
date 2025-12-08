# This module manages the terminfo database
# and its integration in the system.
{ config, lib, pkgs, ... }: {

  options = {
    environment.extraTerminfo = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = ''
        Which terminfo to install on the system
      '';
    };
  };

  config = {

    environment = {
      systemPackages = lib.mkIf (config.environment.extraTerminfo != [ ]) (
        map
          (name: (builtins.getAttr name pkgs.pkgsBuildBuild).terminfo)
          config.environment.extraTerminfo
      );
      pathsToLink = [
        "/share/terminfo"
      ];
      etc.terminfo = {
        source = "${config.system.path}/share/terminfo";
      };
      profileRelativeSessionVariables = {
        TERMINFO_DIRS = [ "/share/terminfo" ];
      };
      extraInit = ''
        # reset TERM with new TERMINFO available (if any)
        export TERM=$TERM
      '';
    };
  };
}
