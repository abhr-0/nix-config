{
  # Import your generated (nixos-generate-config) hardware configuration
  imports = [ ./hardware-configuration.nix ];

  # Feature defaults live in the modules (`features/*`); only enable what
  # differs from the default here. `bootloader` is required by design.
  systemSettings = {
    bootloader = "grub";
    home-manager.enable = true;
    plymouth.enable = true;
    printer.enable = true;
    usbguard.enable = true;
    openssh.enable = true;
  };

  time.timeZone = "Asia/Kolkata";

  # Prevents flickering when booting, but makes the initrd bloated too
  hardware.amdgpu.initrd.enable = true;

  boot.loader.efi = {
    canTouchEfiVariables = true;
    # Using /boot/efi is the mount point as this is a dual-boot system and the EFI partition is
    # shared between Windows and NixOS
    efiSysMountPoint = "/boot/efi";
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
