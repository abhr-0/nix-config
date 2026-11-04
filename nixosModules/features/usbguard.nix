{ config, lib, ... }:
{
  options.systemSettings.usbguard.enable = lib.mkEnableOption "Enable USBGuard service";
  config = {
    services.usbguard = {
      enable = config.systemSettings.usbguard.enable;
      dbus.enable = config.services.usbguard.enable;
      ruleFile = config.sops.secrets.usbguard_rules_file.path;
      IPCAllowedGroups = [ "wheel" ];
    };
  };
}
