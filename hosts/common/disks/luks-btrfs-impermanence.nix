{ disko, lib, ... }: {
  disko.devices = {
    disk.main = {
      type = "disk";
      device = "/dev/nvme0n1";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            priority = 1;
            size = "5G";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "defaults" ];
            };
          };
          luks = {
            size = "100%";
            content = {
              type = "luks";
              name = "cryptroot";
              settings.allowDiscards = true;
              passwordFile = "/tmp/secret.key";
              content = {
                type = "btrfs";
                extraArgs = [ "-L" "nixos" "-f" ];
                subvolumes = {
                  "@root" = {
                    mountpoint = "/";
                    mountOptions = [ "compress=zstd" "noatime" ];
                  };
                  "@persist" = {
                    mountpoint = "/persist";
                    mountOptions = [ "compress=zstd" "noatime" ];
                  };
                  "@nix" = {
                    mountpoint = "/nix";
                    mountOptions = [ "compress=zstd" "noatime" ];
                  };
                  "@swap" = {
                    mountpoint = "/swap";
                    swap.swapfile.size = "32G";
                  };
                };
              };
            };
          };
        };
      };
    };
  };

  fileSystems."/persist".neededForBoot = true;

  # This is what actually gives the impermanence
  # TODO (user9592844): Fix this
  # boot.initrd.postDeviceCommands = lib.mkBefore ''
  #   mkdir -p /mnt
  #   mount -t btrfs -o subvol=/ /dev/mapper/cryproot /mnt
  #   echo "mounted root partition"

  #   btrfs subvolume list -o /mnt/root |
  #     cut -f9 -d' ' |
  #     while read subvolume; do
  #       echo "deleting /$subvolume subvolume..."
  #       btrfs subvolume delete "/mnt/$subvolume"
  #     done &&
  #     echo "deleting /root subvolume..." &&
  #     btrfs subvolume delete /mnt/root
  #     btrfs subvolume create /mnt/root
  #     umount /mnt
  # '';

}
