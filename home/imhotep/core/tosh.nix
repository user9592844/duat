{ pkgs, config, ... }:
let
  tosh = pkgs.writeShellScriptBin "tosh" ''
    #!/usr/bin/env bash
    exec nix-shell ${config.xdg.configHome}/tosh/shell.nix "$@"
  '';
in
{
  # This is the incogni-tosh-ell
  xdg.configFile."tosh/shell.nix".source = ../optional/shells/tosh/shell.nix;

  home.packages = [ tosh ];
}
