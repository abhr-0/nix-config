{
  # Import your generated (nixos-generate-config) hardware configuration
  imports = [ ./hardware-configuration.nix ];

  systemSettings = {
    bootloader = "grub";
    firewalld.enable = false;
    fprint.enable = false;
    homeWifi.enable = false;
    plymouth.enable = true;
    podman.enable = false;
    printer.enable = true;
    usbguard.enable = true;
    virt-manager.enable = false;
  };

  time.timeZone = "Asia/Kolkata";

  # Prevents flickering when booting, but makes the initrd bloated too
  hardware.amdgpu.initrd.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
