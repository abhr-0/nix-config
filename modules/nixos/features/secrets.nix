{
  config,
  inputs,
  lib,
  ...
}:
let
  cfg = config.systemSettings.secrets;
in
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  options.systemSettings.secrets.enable = lib.mkEnableOption "sops-nix secret management";

  config = lib.mkMerge [
    {
      assertions = [
        {
          assertion = cfg.enable || (config.sops.secrets == { } && config.sops.templates == { });
          message = ''
            sops-nix secrets or templates are defined, but systemSettings.secrets.enable is false.
            Either enable systemSettings.secrets.enable or remove the secret definitions.
          '';
        }
      ];
    }
    (lib.mkIf cfg.enable {
      sops = {
        defaultSopsFile = inputs.self + "/secrets/host.yaml";
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
    })
  ];
}
