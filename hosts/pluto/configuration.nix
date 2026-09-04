{
  # Import your generated (nixos-generate-config) hardware configuration
  imports = [ ./hardware-configuration.nix ];

  systemSettings = {
    printer.enable = true;
    bootloader = "grub";
    plymouth.enable = true;
  };

  time.timeZone = "Asia/Kolkata";

  # Prevents flickering when booting, but makes the initrd bloated too
  hardware.amdgpu.initrd.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
