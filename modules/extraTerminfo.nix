# This module manages the terminfo database
# and its integration in the system.
{ config
, lib
, pkgs
, ...
}:
{

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

    # This should not contain packages that are broken or can't build, since it
    # will break this expression
    #
    # can be generated with:
    # lib.attrNames (lib.filterAttrs
    #  (_: drv: (builtins.tryEval (lib.isDerivation drv && drv ? terminfo)).value)
    #  pkgs)
    environment.systemPackages = lib.mkIf (config.environment.extraTerminfo != [ ]) (
      map
        (name: (builtins.getAttr name pkgs.pkgsBuildBuild).terminfo)
        config.environment.extraTerminfo
    );

    environment.pathsToLink = [
      "/share/terminfo"
    ];

    environment.etc.terminfo = {
      source = "${config.system.path}/share/terminfo";
    };

    environment.profileRelativeSessionVariables = {
      TERMINFO_DIRS = [ "/share/terminfo" ];
    };

    environment.extraInit = ''

      # reset TERM with new TERMINFO available (if any)
      export TERM=$TERM
    '';
  };
}
