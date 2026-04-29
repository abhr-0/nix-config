{
  # checkout the example folder for how to configure different disko layouts
  disko.devices = {
    disk = {
      main = {
        device = "/dev/disk/by-id/nvme-SKHynix_HFS512GEJ9X115N_AMC5N00461390621L";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              type = "EF00";
              size = "512M";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            luks-root = {
              size = "75%"; # Adjust as needed
              content = {
                type = "luks";
                name = "cryptroot";
                # disable passwordFile for interactive password entry
                # passwordFile = "/tmp/secret.key";
                # enrollRecovery = true; # Enable recovery key enrollment
                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ]; # Force format, be careful with this!
                  subvolumes = {
                    "/root" = {
                      mountpoint = "/";
                      mountOptions = [
                        "compress=zstd:1"
                        "noatime"
                      ];
                    };
                    "/home" = {
                      mountpoint = "/home";
                      mountOptions = [
                        "compress=zstd:1"
                        "noatime"
                      ];
                    };
                    "/nix" = {
                      mountpoint = "/nix";
                      mountOptions = [
                        "compress=zstd:1"
                        "noatime"
                      ];
                    };
                  };
                };
              };
            };

            # Enable encrypted swap for hibernation support
            luks-swap = {
              size = "16G"; # Adjust as needed
              content = {
                type = "luks";
                name = "cryptswap";

                # Do not use keyFile, use same password as root to automatically unlock swap when root is unlocked
                passwordFile = "/tmp/secret.key";
                content = {
                  type = "swap";
                  resumeDevice = true; # Enable hibernation support
                };
              };
            };
          };
        };
      };
    };
  };
}
