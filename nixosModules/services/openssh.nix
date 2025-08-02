{ pkgs, ... }:
{
  # Note: Needed by sops to generate host key file
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no"; # Forbid root login through SSH
      PasswordAuthentication = false; # Disable password based authentication
      # KbdInteractiveAuthentication = true; # True by default
      AuthenticationMethods = "publickey,keyboard-interactive";
    };
  };

  # security.pam.services.sshd.googleOsLoginAuthentication = true; # ??
  # security.pam.services.sshd.googleAuthenticator.enable = true; # TODO: Does not work, look into https://github.com/NixOS/nixpkgs/issues/115044

  security.pam.services.sshd.text = ''
    account required pam_unix.so # unix (order 10900)

    auth required ${pkgs.google-authenticator}/lib/security/pam_google_authenticator.so nullok no_increment_hotp # google_authenticator (order 12500)
    auth sufficient pam_permit.so

    session required pam_env.so conffile=/etc/pam/environment readenv=0 # env (order 10100)
    session required pam_unix.so # unix (order 10200)
    session required pam_loginuid.so # loginuid (order 10300)
    session optional ${pkgs.systemd}/lib/security/pam_systemd.so # systemd (order 12000)
  '';
}
