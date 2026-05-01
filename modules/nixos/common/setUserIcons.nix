{ inputs, ... }:
let
  iconsForUsers = [ "abhro" ];
in
{
  sops.secrets = builtins.listToAttrs (
    map (username: {
      name = "${username}Icon";
      value = {
        format = "binary";
        sopsFile = "${inputs.nix-secrets}/secrets/${username}Icon.enc";
        path = "/var/lib/AccountsService/icons/${username}";
        mode = "0644";
      };
    }) iconsForUsers
  );

  # See: https://github.com/NixOS/nixpkgs/issues/163080
  #      https://discourse.nixos.org/t/setting-the-user-profile-image-under-gnome/36233/3
  systemd.services = builtins.listToAttrs (
    map (username: {
      name = "${username}-user-icon";
      value = {
        description = "Set user ${username}'s icon";
        enableStrictShellChecks = true;

        before = [ "display-manager.service" ];
        wantedBy = [ "display-manager.service" ];

        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
        };

        script = ''
          if grep -q '^Icon=/var/lib/AccountsService/icons/${username}' /var/lib/AccountsService/users/${username}; then
            echo "User icon is defined correctly. Exiting."
            exit 0
          else
            echo "User icon is defined INCORRECTLY. Changing line and exiting."
            sed -i "s|^Icon=.*|Icon=/var/lib/AccountsService/icons/${username}|" /var/lib/AccountsService/users/${username}
          fi

          exit 0
        '';
      };
    }) iconsForUsers
  );
}
