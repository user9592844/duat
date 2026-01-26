{ pkgs, ... }: {
  home.packages = with pkgs; [ terraform ];
  nixpkgs.config.allowUnfree = true;
}
