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

    # DNS Nameservers
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
      "8.8.8.8"
    ];
  };

  # systemd-resolvd config
  # Look: https://nixos.wiki/wiki/Encrypted_DNS#Setting_nameservers
  services.resolved = {
    enable = true;
    domains = [ "~." ];
    dnsovertls = "true";
    dnssec = "true";
  };
}
