{
  inputs,
  config,
  lib,
  ...
}:
{
  options.systemSettings.homeWifi.enable = lib.mkEnableOption "Enable Home Wi-Fi configuration";

  config = lib.mkIf config.systemSettings.homeWifi.enable {
    sops = {
      secrets = {
        home_wifi_password.sopsFile = "${inputs.nix-secrets}/secrets/host.yaml";
      };
      templates = {
        "network_manager.env".content = ''
          HOME_WIFI_PASSWORD=${config.sops.placeholder.home_wifi_password}
        '';
      };
    };

    networking.networkmanager.ensureProfiles = {
      environmentFiles = [ "${config.sops.templates."network_manager.env".path}" ];
      profiles = {
        JioFiber-5G = {
          connection = {
            id = "JioFiber-5G";
            interface-name = "wlp3s0";
            type = "wifi";
          };
          ipv4 = {
            method = "auto";
          };
          ipv6 = {
            addr-gen-mode = "default";
            method = "auto";
          };
          proxy = { };
          wifi = {
            mode = "infrastructure";
            ssid = "JioFiber-5G";
          };
          wifi-security = {
            auth-alg = "open";
            key-mgmt = "wpa-psk";
            psk = "$HOME_WIFI_PASSWORD";
          };
        };
      };
    };
  };
}
