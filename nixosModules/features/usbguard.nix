{ config, lib, ... }:
let
  cfg = config.systemSettings.usbguard;
in
{
  options.systemSettings.usbguard = {
    enable = lib.mkEnableOption "Enable USBGuard service";
    sopsFile = lib.mkOption {
      type = lib.types.path;
      default = ../../secrets/${config.networking.hostName}.yaml;
      description = "sops file containing the usbguard_rules_file secret";
    };
  };

  config = lib.mkIf cfg.enable {
    sops.secrets.usbguard_rules_file.sopsFile = cfg.sopsFile;

    services.usbguard = {
      enable = true;
      dbus.enable = true;
      ruleFile = config.sops.secrets.usbguard_rules_file.path;
      IPCAllowedGroups = [ "wheel" ];
    };
  };
}
