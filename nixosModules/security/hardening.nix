{ lib, ... }:
{
  security = {
    # su, sudo and root user config
    sudo-rs = {
      enable = true;
      wheelNeedsPassword = true;
      execWheelOnly = true; # Prevents bugs like CVE-2021-3156
    };

    sudo.enable = false;
    # sudo.execWheelOnly = true; # Prevents bugs like CVE-2021-3156

    # Ensure only users in wheel group can use su
    pam.services.su.requireWheel = true;

    # Enable AppArmor
    apparmor.enable = lib.mkDefault true;
    apparmor.killUnconfinedConfinables = lib.mkDefault true;
  };

  # imports = [ "${modulesPath}/profiles/hardened.nix" ]; # Causes issues
  # boot.kernelPackages = pkgs.linuxPackages_hardened; # Causes issues

  # Disable coredumps
  systemd.coredump.enable = false;

  # Enable OpenSnitch
  # services.opensnitch.enable = true;

  # Recommended to be set to false, as it allows gaining root access by modifying kernel parameters
  # Enabled by default for backwards compatibility.
  boot.loader.systemd-boot.editor = false;
}
