{ config, ... }:
{
  services.usbguard = {
    enable = true;
    dbus.enable = true;
    ruleFile = config.sops.secrets.usbguard_rules_file.path;
    IPCAllowedGroups = [ "wheel" ];
  };
}
