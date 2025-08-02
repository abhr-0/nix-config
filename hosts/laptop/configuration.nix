{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    # Import common hardware configs from nixos-hardware
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd

    # Import Lanzaboote module
    inputs.lanzaboote.nixosModules.lanzaboote

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix

    # Custom local modules
    ../../nixosModules
  ];

  nixpkgs.config.allowUnfreePredicate = lib.mkDefault (
    pkg:
    builtins.elem (lib.getName pkg) [
      "libfprint-2-tod1-elan"
      "steam"
      "steam-unwrapped"
    ]
  );

  # Enable fingerprint reader support
  services.fprintd = {
    enable = true;
    package = pkgs.fprintd-tod;
    tod.enable = true;
    tod.driver = pkgs.libfprint-2-tod1-elan;
  };

  # config.myModule.enableHpPrinter = true; # Incase printer support is needed

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  environment.systemPackages = with pkgs; [
    tpm-tools # Enable TPM support
    sbctl # For secureboot
  ];

  boot = {
    # Enable TPM support
    initrd = {
      systemd.enable = true;
      systemd.tpm2.enable = true;

      verbose = false; # For silent boot
    };

    # Bootloader configuration
    loader = {
      efi = {
        canTouchEfiVariables = true;
        # assuming /boot is the mount point of the  EFI partition in NixOS (as the installation section recommends).
        efiSysMountPoint = "/boot";
      };
      systemd-boot.enable = lib.mkForce false;

      # Hide the OS choice for bootloaders.
      # It's still possible to open the bootloader list by pressing any key
      # It will just not appear on screen unless a key is pressed
      timeout = 2;
    };
    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };

    # Enable plymouth
    plymouth.enable = true;

    # Enable "Silent Boot"
    consoleLogLevel = 0;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
