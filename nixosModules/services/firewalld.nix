{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.firewalld-gui ];

  networking.nftables.enable = true; # Used by firewalld

  services.firewalld = {
    enable = true;
    services = {
      localsend_app = {
        short = "LocalSend";
        ports = [
          {
            port = 53317;
            protocol = "tcp";
          }
        ];
      };
      immich = {
        short = "Immich";
        ports = [
          {
            port = 2283;
            protocol = "tcp";
          }
        ];
      };
    };
    zones = {
      home.services = [
        "dhcpv6-client"
        "localsend_app"
        "mdns"
        # "samba-client"
        "ssh"
      ];
    };
  };
}
