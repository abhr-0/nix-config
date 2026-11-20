{ config, lib, ... }:
let
  cfg = config.systemSettings.openssh;
in
{
  options.systemSettings.openssh.enable = lib.mkEnableOption "Enable OpenSSH for remote access";

  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = true;
      openFirewall = true;
      startWhenNeeded = true; # WARN: Has issues. Link: https://wiki.archlinux.org/title/OpenSSH#Socket_activation
      settings = {
        AllowUsers = [ "abhro" ]; # Allows all users if not set
        PermitRootLogin = "no";
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        AuthenticationMethods = "publickey";
      };
    };
  };
}
