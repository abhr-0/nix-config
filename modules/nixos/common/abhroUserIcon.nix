{ pkgs, ... }: {
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
}
