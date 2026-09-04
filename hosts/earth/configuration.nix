{
  # Import your generated (nixos-generate-config) hardware configuration
  imports = [ ./hardware-configuration.nix ];

  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
    fileSystems = [ "/" ];
  };

  systemSettings = {
    podman.enable = true;
    virt-manager.enable = true;
    firewalld.enable = true;
    homeWifi.enable = true;
    fprint.enable = true;
    plymouth.enable = true;
    bootloader = "lanzaboote";
  };

  time.timeZone = "Asia/Kolkata";

  # Prevents flickering when booting, but makes the initrd bloated too
  hardware.amdgpu.initrd.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
