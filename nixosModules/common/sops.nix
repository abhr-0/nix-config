{ inputs, ... }:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops = {
    defaultSopsFile = ../../secrets/host.yaml;
    defaultSopsFormat = "yaml";

    # Disable automatic importing of SSH host keys
    age = {
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = false; # FIXME: DOESN'T use PQ, Look: https://github.com/Mic92/sops-nix/pull/942
      # plugins = ; # Useful with: https://github.com/str4d/age-plugin-yubikey
      sshKeyPaths = [ ];
    };
    gnupg.sshKeyPaths = [ ];
  };
}
