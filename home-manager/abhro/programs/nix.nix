{ config, inputs, ... }:
{
  # NixOS tooling
  imports = [ inputs.nix-index-database.homeModules.nix-index ];

  programs = {
    nix-index-database.comma.enable = true;

    nh = {
      enable = true;
      flake = "${config.home.homeDirectory}/Projects/nix-config"; # Note: This is subject to change in the future
    };
  };

  # home.packages = with pkgs; [
  #   vulnix
  # ];
}
