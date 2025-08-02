{ hostName, ... }:
{
  networking = {
    # Sets the host name
    inherit hostName;

    # Open ports in the firewall.
    firewall = {
      allowedTCPPorts = [
        # 2283 # Immich API
        53317 # LocalSend
      ];
    };

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
      "9.9.9.9"
      "149.112.112.112"
    ];
  };
}
