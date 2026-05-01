{ inputs, ... }:
{
  imports = [
    # Import common hardware configs from nixos-hardware
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
  ];

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

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
