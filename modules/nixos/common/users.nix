{
  config,
  pkgs,
  lib,
  ...
}:
{
  # This is required to be able to use the `path` attribute of secrets in users.user.<user>.hashedPasswordFile
  sops.secrets.abhro-password.neededForUsers = true;

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
