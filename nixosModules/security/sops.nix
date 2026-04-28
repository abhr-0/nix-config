{
  config,
  inputs,
  lib,
  ...
}:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops = {
    defaultSopsFile = "${inputs.nix-secrets}/secrets/host.yaml";
    defaultSopsFormat = "yaml";

    age = {
      keyFile = "/var/lib/sops-nix/keys.txt";
      # generateKey = true;
    };

    gnupg.sshKeyPaths = [ ];

    secrets = {
      abhro-password.neededForUsers = true;
      usbguard_rules_file = {
        sopsFile = "${inputs.nix-secrets}/secrets/${config.networking.hostName}.yaml";
      };

      # TODO: Shift this to a separate module
      home_wifi_password = lib.mkIf (config.networking.hostName == "laptop") {
        sopsFile = "${inputs.nix-secrets}/secrets/laptop.yaml";
      };
    };

    # TODO: Same as above
    templates."network_manager.env".content = lib.mkIf (config.networking.hostName == "laptop") ''
      HOME_WIFI_PASSWORD=${config.sops.placeholder.home_wifi_password}
    '';
  };
}
