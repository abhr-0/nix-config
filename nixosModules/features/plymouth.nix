{ config, lib, ... }:
let
  cfg = config.systemSettings.plymouth;
in
{
  options.systemSettings.plymouth.enable = lib.mkEnableOption "Enable Plymouth for splash screen during boot";

  config = lib.mkIf cfg.enable {
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
  };
}
