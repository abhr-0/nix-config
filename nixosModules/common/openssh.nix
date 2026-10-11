{
  services.openssh = {
    enable = true;
    # openFirewall = true; # NOTE: Set in ../features/firewalld.nix
    startWhenNeeded = true; # WARN: Has issues. Link: https://wiki.archlinux.org/title/OpenSSH#Socket_activation
    settings = {
      AllowUsers = [ "abhro" ]; # Allows all users if not set
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      AuthenticationMethods = "publickey";
    };
  };
}
