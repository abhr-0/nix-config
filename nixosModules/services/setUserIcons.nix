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
          # Check whether /var/lib/AccountsService/users/USERNAME exists
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
        '';
      };
    }) iconsForUsers
  );
}
