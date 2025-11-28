{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    podman-compose # KEEP: `podman compose` uses this
  ];

  # Enable virt-manager for working with VMs
  programs.virt-manager.enable = true;

  virtualisation = {
    # Enable common container config files in /etc/containers
    containers.enable = true;

    # Enable Podman
    podman = {
      enable = true;
      dockerCompat = true; # Create `docker` alias for podman

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };

    # Enable libvirtd (Needed by virt-manager)
    libvirtd = {
      enable = true;
      qemu.swtpm.enable = true; # Enable software TPM
      qemu.vhostUserPackages = [ pkgs.virtiofsd ];
    };

    #spiceUSBRedirection.enable = true;
  };
}
