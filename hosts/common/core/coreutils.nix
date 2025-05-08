{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.uutils-coreutils ];
}
