{ config, lib, ... }:
{
  options.systemSettings.plymouth.enable = lib.mkEnableOption "Enable Plymouth for splash screen during boot";

  config = lib.mkIf config.systemSettings.plymouth.enable {
    boot = {
      plymouth.enable = true;

      # Enable "Silent Boot"
      initrd.verbose = false;
      consoleLogLevel = 0;
      kernelParams = [
        "quiet"
        "splash"
        "boot.shell_on_fail"
        "loglevel=3"
        "rd.systemd.show_status=false"
        "rd.udev.log_level=3"
        "udev.log_priority=3"
      ];
    };

    # Hide the OS choice for bootloaders.
    # It's still possible to open the bootloader list by pressing any key
    # It will just not appear on screen unless a key is pressed
    # timeout = 0;
  };
}
