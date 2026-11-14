{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.systemSettings.virt-manager;
in
{
  options.systemSettings.virt-manager.enable = lib.mkEnableOption "Enable virt-manager for working with VMs";

  config = lib.mkIf cfg.enable {
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
