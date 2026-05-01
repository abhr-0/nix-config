{ config, inputs, ... }:
{
  sops.secrets.usbguard_rules_file.sopsFile = "${inputs.nix-secrets}/secrets/${config.networking.hostName}.yaml";
  services.usbguard = {
    enable = true;
    dbus.enable = true;
    ruleFile = config.sops.secrets.usbguard_rules_file.path;
    IPCAllowedGroups = [ "wheel" ];
  };
}
