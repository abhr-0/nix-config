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
}
