{
  config,
  pkgs,
  lib,
  ...
}:
{
  # Enable zsh as it is required by users.user.<user>.shell = zsh;
  programs.zsh.enable = true;

  users.users = {
    abhro = {
      hashedPasswordFile = config.sops.secrets.abhro-password.path;
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
}
