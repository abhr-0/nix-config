{ config, ... }:
{
  services.usbguard = {
    enable = true;
    dbus.enable = true;
    ruleFile = config.sops.secrets.usbguard_rules_file.path;
  };
  # environment.systemPackages = [ pkgs.usbguard-notifier ]; TODO: Doesn't work??
}
