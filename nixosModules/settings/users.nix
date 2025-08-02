{
  config,
  inputs,
  pkgs,
  ...
}:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

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
        "scanner"
        "lp"
      ];

      shell = pkgs.zsh;

      # openssh.authorizedKeys.keys = [ ];
    };

    # Disable root login
    root.hashedPassword = "!";
  };

  home-manager = {
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs; };
    users.abhro = ../../home-manager/abhro/home.nix; # TODO
  };
}
