{ config, inputs, ... }:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops = {
    defaultSopsFile = "${inputs.nix-secrets}/secrets/host.yaml";
    defaultSopsFormat = "yaml";

    age = {
      keyFile = "/var/lib/sops-nix/age/keys.txt";
      # generateKey = true;
    };

    gnupg.sshKeyPaths = [ ];

    secrets = {
      abhro-password.neededForUsers = true;
      usbguard_rules_file = { };
      home_wifi_password = { };
    };

    templates."network_manager.env".content = ''
      HOME_WIFI_PASSWORD=${config.sops.placeholder.home_wifi_password}
    '';
  };
}
