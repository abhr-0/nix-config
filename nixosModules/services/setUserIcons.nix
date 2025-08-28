{ config, ... }:
let
  iconsForUsers = [ "abhro" ];
in
{
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
          mkdir -p /var/lib/AccountsService/{icons,users}

          # Check whether /var/lib/AccountsService/icons/USERNAME exists, copy if not
          if [ -f "/var/lib/AccountsService/icons/${username}" ]; then
            echo "/var/lib/AccountsService/icons/${username} exists."
          else
            echo "/var/lib/AccountsService/icons/${username}" does not exist. Copying.
            cp ${config.sops.secrets."${username}Icon".path} /var/lib/AccountsService/icons/${username}
          fi

          # Check whether /var/lib/AccountsService/users/USERNAME exists, create the file if it doesn't
          if [ -f "/var/lib/AccountsService/users/${username}" ]; then
            echo "/var/lib/AccountsService/users/${username} exists."
            # Check whether /var/lib/AccountsService/users/USERNAME has User's Icon defined
            if grep -q '^Icon=' /var/lib/AccountsService/users/${username}; then
              echo "User icon is defined. Exiting."
              exit 0
            else
              echo "User icon not defined. Adding line and exiting."
              echo -e "Icon=/var/lib/AccountsService/icons/${username}\n" >> /var/lib/AccountsService/users/${username}
            fi
          else
            echo "/var/lib/AccountsService/users/${username} DOES NOT exist. Skipping."
            exit 1
            # echo -e "[User]\nSession=gnome\nSessionType=wayland\nIcon=/var/lib/AccountsService/icons/${username}\nSystemAccount=false\n" > /var/lib/AccountsService/users/${username}
          fi

          chown root:root /var/lib/AccountsService/users/${username}
          chmod 0600 /var/lib/AccountsService/users/${username}

          chown root:root /var/lib/AccountsService/icons/${username}
          chmod 0644 /var/lib/AccountsService/icons/${username}
        '';
      };
    }) iconsForUsers
  );
}
