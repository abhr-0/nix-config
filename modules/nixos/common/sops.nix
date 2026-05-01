{ inputs, ... }:
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
  };
}
