{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.systemSettings.secrets;
  abhro = config.users.users.abhro;
in
{
  config = lib.mkMerge [
    {
      # Sops provides the password hash by default. A host may disable it and
      # provide one of the other password options instead; the assertion below
      # ensures a password source is always configured.
      systemSettings.secrets.enable = lib.mkDefault true;

      # Enable zsh as it is required by users.user.<user>.shell = zsh;
      programs.zsh.enable = true;

      users.users = {
        abhro = {
          isNormalUser = true;

          description = "Abhraneel Mukherjee";

          # Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
          extraGroups = [
            "networkmanager"
            "wheel"
            "libvirtd"
          ]
          ++ lib.optional config.services.printing.enable "lp"
          ++ lib.optional config.hardware.sane.enable "scanner";

          shell = pkgs.zsh;

          # openssh.authorizedKeys.keys = [ ];
        };

        # Disable root login
        root.hashedPassword = "!";
      };

      # TODO: This assertion only covers `abhro`; generalize it for all users
      # that need a password configured.
      assertions = [
        {
          assertion =
            abhro.hashedPassword != null
            || abhro.hashedPasswordFile != null
            || abhro.password != null
            || abhro.passwordFile != null
            || abhro.initialHashedPassword != null
            || abhro.initialPassword != null;
          message = ''
            No password has been configured for users.users.abhro.

            Set exactly one of:
              - users.users.abhro.hashedPassword
              - users.users.abhro.hashedPasswordFile
              - users.users.abhro.password
              - users.users.abhro.passwordFile
              - users.users.abhro.initialHashedPassword
              - users.users.abhro.initialPassword

            or enable systemSettings.secrets.enable to use the sops-managed password.
          '';
        }
      ];
    }
    (lib.mkIf cfg.enable {
      # This is required to be able to use the `path` attribute of secrets in users.user.<user>.hashedPasswordFile
      sops.secrets.abhro-password.neededForUsers = true;
      users.users.abhro.hashedPasswordFile = config.sops.secrets.abhro-password.path;
    })
  ];
}
