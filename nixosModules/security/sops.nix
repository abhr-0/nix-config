{ inputs, ... }:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops = {
    defaultSopsFile = "${inputs.nix-secrets}/secrets/host.yaml";
    defaultSopsFormat = "yaml";

    age.keyFile = "/var/lib/sops-nix/age/keys.txt";

    secrets = {
      abhro-password.neededForUsers = true;
      usbguard_rules_file = { };
    };
  };
}
