{ inputs, ... }:
{
  # options = {
  #   userIcons = lib.mkOption {
  #     type = lib.types.listOf lib.types.str;
  #     default = [ ];
  #     example = [ "abhro" ];
  #     description = "Whether to enable this cool module.";
  #   };
  # };

  # See: https://github.com/NixOS/nixpkgs/issues/163080
  #      https://discourse.nixos.org/t/setting-the-user-profile-image-under-gnome/36233/3
  config = {
    systemd.services =
      let
        username = "abhro";
      in
      {
        "${username}-user-icon" = {
          description = "Set ${username} user's icon";
          enableStrictShellChecks = true;

          before = [ "display-manager.service" ];
          wantedBy = [ "display-manager.service" ];

          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
          };

          script = ''
            mkdir -p /var/lib/AccountsService/{icons,users}
            cp ${inputs.nix-secrets}/secrets/abhro.png /var/lib/AccountsService/icons/${username}

            # Check whether /var/lib/AccountsService/users/USERNAME exists, create the file if it doesn't
            if [ -f "/var/lib/AccountsService/users/${username}" ]; then
              echo "/var/lib/AccountsService/icons/${username} exists."
              # Check whether /var/lib/AccountsService/users/USERNAME has User's Icon defined
              if grep -q '^Icon=' /var/lib/AccountsService/users/${username}; then
                echo "User icon is defined. Exiting."
                exit 0
              else
                echo "User icon not defined. Adding line and exiting."
                echo -e "Icon=/var/lib/AccountsService/icons/${username}\n" >> /var/lib/AccountsService/users/${username}
              fi
            else
              echo "/var/lib/AccountsService/icons/${username} DOES NOT exist. Skipping."
              # echo -e "[User]\nSession=gnome\nSessionType=wayland\nIcon=/var/lib/AccountsService/icons/${username}\nSystemAccount=false\n" > /var/lib/AccountsService/users/${username}
            fi

            chown root:root /var/lib/AccountsService/users/${username}
            chmod 0600 /var/lib/AccountsService/users/${username}

            chown root:root /var/lib/AccountsService/icons/${username}
            chmod 0644 /var/lib/AccountsService/icons/${username}
          '';
        };
      };
  };
}
