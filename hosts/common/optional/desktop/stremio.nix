{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ stremio ];
  nixpkgs.config.allowUnfree = true;
}
