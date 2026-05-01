{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

  options.systemSettings.bootloader = lib.mkOption {
    type = lib.types.enum [
      "grub"
      "lanzaboote"
      "none"
    ];
    default = null; # set to null to force explicit choice
    description = "Bootloader configuration";
  };

  config = lib.mkMerge [
    (lib.mkIf (config.systemSettings.bootloader == "grub") {
      boot.loader = {
        # Using /boot/efi is the mount point as this is a dual-boot system and
        # the EFI partition is shared between Windows and NixOS
        efi.efiSysMountPoint = "/boot/efi";

        grub = {
          enable = true;

          # Needed to pass an assert in nixpkgs's grub.nix
          # This isn't used by the EFI grub install
          device = "nodev";

          efiSupport = true;
          useOSProber = true; # To detect Windows installation
          default = 2; # To select Windows to be the default option

          # Hide the OS choice for bootloaders.
          # It's still possible to open the bootloader list by holding the
          # "Shift" key during boot
          timeoutStyle = "hidden";
        };
      };
    })
    (lib.mkIf (config.systemSettings.bootloader == "lanzaboote") {
      environment.systemPackages = with pkgs; [
        tpm-tools # For TPM
        sbctl # For secureboot
      ];

      boot = {
        # Enable TPM support
        initrd = {
          systemd.enable = true;
          systemd.tpm2.enable = true;
        };

        # Bootloader configuration
        loader = {
          # assuming /boot is the mount point of the  EFI partition in NixOS
          # (as the installation section recommends).
          efi.efiSysMountPoint = "/boot"; # Default

          systemd-boot.enable = lib.mkForce false;

          # Hide the OS choice for bootloaders.
          # It's still possible to open the bootloader list by holding "Esc"
          # or "Space" key
          timeout = 0;
        };

        lanzaboote = {
          enable = true;
          pkiBundle = "/var/lib/sbctl";

          autoGenerateKeys.enable = true;
          autoEnrollKeys = {
            enable = true;
            # Automatically reboot to enroll the keys in the firmware
            autoReboot = true;
          };

          # TODO: Enable later as lanzaboote v1.0.0 doesn't support measured
          # boot, next release should have it
          # measuredBoot = {
          #   enable = true;
          #   pcrs = [
          #     0
          #     4
          #     7
          #   ];
          # };
        };
      };
    })
    (lib.mkIf (config.systemSettings.bootloader != "none") {
      boot.loader = {
        efi.canTouchEfiVariables = true;
      };
    })
  ];
}
