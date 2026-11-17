{
  # Import your generated (nixos-generate-config) hardware configuration
  imports = [
    ./hardware-configuration.nix
    ./workarounds.nix
  ];

  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
    fileSystems = [ "/" ];
  };

  home-manager.users.abhro.programs.vscode.enable = true;

  # Feature defaults live in the modules (`features/*`); only enable what
  # differs from the default here. `bootloader` is required by design.
  systemSettings = {
    bootloader = "lanzaboote";
    firewalld.enable = true;
    fprint.enable = true;
    homeWifi.enable = true;
    plymouth.enable = true;
    podman.enable = true;
    usbguard.enable = true;
  };

  time.timeZone = "Asia/Kolkata";

  # Prevents flickering when booting, but makes the initrd bloated too
  hardware.amdgpu.initrd.enable = true;

  # WARN: DO NOT REMOVE, need to enable systemd in initrd to detect swapfile
  boot.initrd.systemd.enable = true;
  swapDevices = [
    {
      device = "/swap/swapfile"; # NOTE: Default swap priority is less than zram
      size = 24 * 1024; # 24GiB
    }
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
