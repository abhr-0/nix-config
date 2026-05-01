{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.systemSettings.virt-manager.enable = lib.mkEnableOption "Enable virt-manager for working with VMs";

  config = lib.mkIf config.systemSettings.virt-manager.enable {
    programs.virt-manager.enable = true;

    # Enable libvirtd (Needed by virt-manager)
    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          swtpm.enable = true; # Enable software TPM
          vhostUserPackages = [ pkgs.virtiofsd ];
        };
      };

      spiceUSBRedirection.enable = true;
    };
  };
}
