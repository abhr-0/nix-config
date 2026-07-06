{ inputs, ... }:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops = {
    defaultSopsFile = "../../secrets/host.yaml";
    defaultSopsFormat = "yaml";

    # Disable automatic importing of SSH host RSA keys as GPG keys for sops
    gnupg.sshKeyPaths = [ ];
  };
}
