{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.systemSettings;
in
{
  config = lib.mkMerge [
    {
      # abhro's password comes from sops, so this user requires the secrets
      # module. A host that supplies a password another way (e.g. `password`,
      # as the VM variant does) can still override this to false; the assertion
      # below ensures a password source is always configured.
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
      assertions =
        let
          abhro = config.users.users.abhro;
        in
        [
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
    # abhro's home tree. HM is used as a NixOS module, so the attach point lives
    # with the user rather than in features/home-manager.nix. That module is
    # always imported, so `home-manager.users` exists even when this is off.
    (lib.mkIf cfg.home-manager.enable {
      home-manager.users.abhro = inputs.import-tree ../../home-manager;
    })
    (lib.mkIf cfg.secrets.enable {
      # This is required to be able to use the `path` attribute of secrets in users.user.<user>.hashedPasswordFile
      sops.secrets.abhro-password.neededForUsers = true;
      users.users.abhro.hashedPasswordFile = config.sops.secrets.abhro-password.path;
    })
    # AccountsService owns the login avatar; only manage it when a display manager
    # reads it. Both hosts run GDM, so this is true today.
    (lib.mkIf config.services.displayManager.enable {
      # See: https://github.com/NixOS/nixpkgs/issues/163080
      #      https://discourse.nixos.org/t/setting-the-user-profile-image-under-gnome/36233/3
      systemd.services.abhro-user-icon =
        let
          abhro-icon = pkgs.fetchurl {
            url = "https://avatars.githubusercontent.com/abhr-0";
            hash = "sha256-63ZTP/6ieotW06YJufDI4uk7TricAtAkzTKAwdOwu18=";
          };
          icon-path = "/var/lib/AccountsService/icons/abhro";
        in
        {
          description = "Set user abhro's icon";
          enableStrictShellChecks = true;

          before = [ "display-manager.service" ];
          wantedBy = [ "display-manager.service" ];
          after = [ "accounts-daemon.service" ];

          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
          };

          script = ''
            ln -sfn ${abhro-icon} ${icon-path}

            busctl call org.freedesktop.Accounts "/org/freedesktop/Accounts/User$(id -u abhro)" \
            org.freedesktop.Accounts.User SetIconFile s "${icon-path}"
          '';
        };
    })
  ];
}
