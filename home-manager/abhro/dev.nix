{
  pkgs,
  inputs,
  hostName,
  ...
}:
{
  imports = [ inputs.nix-index-database.homeModules.nix-index ];

  home.packages = with pkgs; [
    ollama
    nixd
    nixfmt
    # vulnix
  ];

  programs = {
    nix-index-database.comma.enable = true;

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    vscode.enable = hostName == "earth";
  };

  # Note: GNOME's seahorse replaces the functionality of ssh, ssh-agent, gpg and gpg-agent
  #
  # programs.gpg.enable = true;
  # services.gpg-agent = {
  #   enable = true;
  #   pinentryPackage = pkgs.pinentry-gnome3;
  # };

  home.sessionVariables = {
    # EDITOR = "${config.programs.vscode.package}/bin/code --wait";
  };
}
