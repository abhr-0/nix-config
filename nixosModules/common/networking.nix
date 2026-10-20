{ hostName, ... }:
{
  networking = {
    # Sets the host name
    inherit hostName;

    # MAC Address randomisation
    networkmanager = {
      ethernet.macAddress = "stable"; # Also available: `random` and default is `preserve`

      wifi.macAddress = "stable-ssid";
      # stable: The same generated MAC address will be used for all Wi-Fi networks.
      # stable-ssid: A unique MAC address for each Wi-Fi network (SSID)
    };

    # Block malicious hosts
    stevenblack.enable = true;

    # Set in resolved config below
    # nameservers = [ ];
  };

  # NOTE: FallbackDNS isn't set, a default compiled-in list is used automatically
  # Check `resolvectl status` to get the list
  services.resolved = {
    enable = true;
    settings.Resolve = {
      DNS = [
        "1.1.1.1#one.one.one.one"
        "1.0.0.1#one.one.one.one"
      ];
      Domains = [ "~." ];
      DNSOverTLS = "true";
      DNSSEC = "true";
    };
  };
}
