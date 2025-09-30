{
  # VirtualBox has an unfree license
  nixpkgs.config.allowUnfree = true;

  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;

  # BUG: https://discourse.nixos.org/t/issue-with-virtualbox-in-24-11/57607
  boot.kernelParams = [ "kvm.enable_virt_at_load=0" ];
}
