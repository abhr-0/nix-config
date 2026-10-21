{ config, lib, ... }:
{
  options.systemSettings.firewalld.enable = lib.mkEnableOption "Enable firewalld for firewall management";

  # https://wiki.nixos.org/wiki/Firewall#Firewalld
  config = lib.mkIf config.systemSettings.firewalld.enable {
    # environment.systemPackages = [ pkgs.firewalld-gui ];

    networking.nftables.enable = true; # Used by firewalld

    services.firewalld = {
      enable = true;

      /*nixfmt:disable*/
      services = {
        localsend = {
          short = "LocalSend";
          ports = [ { port = 53317; protocol = "tcp"; } ];
        };
        immich = {
          short = "Immich";
          ports = [ { port = 2283; protocol = "tcp"; } ];
        };
      };
      /*nixfmt:enable*/

      settings.DefaultZone = "drop";

      zones.nixos-fw-default.services = [ "kdeconnect" ];
    };
  };
}
