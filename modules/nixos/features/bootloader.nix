{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.systemSettings;
in
{
  imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

  options.systemSettings.bootloader = lib.mkOption {
    type = lib.types.enum [
      "grub"
      "lanzaboote"
      "unmanaged"
    ];
    description = ''
      Bootloader configuration for this host. No default is set, so every host has
      to choose one explicitly.

      - `grub`: GRUB, installed for EFI. Kernel parameters can be edited at boot.
      - `lanzaboote`: signed EFI binaries with secure boot and measured boot.
      - `unmanaged`: this module configures no bootloader, so the nixpkgs defaults
        apply and GRUB remains enabled to avoid a host with no bootloader. Used by
        the VM variant and by hosts that manage their own bootloader.
    '';
  };

  config = lib.mkMerge [
    (lib.mkIf (cfg.bootloader == "grub") {
      boot.loader.grub = {
        enable = true;
        efiSupport = true;

        # Needed to pass an assert in nixpkgs's grub.nix
        # This isn't used by the EFI grub install
        device = "nodev";

        # Hide the OS choice for bootloaders.
        # It's still possible to open the bootloader list by holding the "Shift" key during boot
        timeoutStyle = "hidden";
      };
    })
    (lib.mkIf (cfg.bootloader == "lanzaboote") {
      environment.systemPackages = [ pkgs.sbctl ]; # For secureboot

      # Bootloader configuration
      boot = {
        loader = {
          systemd-boot = {
            enable = lib.mkForce false;

            # Recommended to be set to false, as it allows gaining root access by modifying kernel parameters
            # Enabled by default for backwards compatibility.
            # Lanzaboote automatically sets it's editor option to this value
            editor = false;
          };

          # Hide the OS choice for bootloaders.
          # It's still possible to open the bootloader list by holding "Esc" or "Space" key
          timeout = 0;
        };

        lanzaboote = {
          enable = true;
          pkiBundle = "/var/lib/sbctl";

          autoGenerateKeys.enable = true;
          autoEnrollKeys = {
            enable = true;
            autoReboot = true; # Automatically reboot to enroll the keys in the firmware
          };

          # NOTE: Max config limit is 4 for measured boot
          configurationLimit = 4;
          measuredBoot = {
            enable = true;
            pcrs = [
              0
              4
              7
            ];
          };
        };
      };
    })
  ];
}
