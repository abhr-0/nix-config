{ pkgs, ... }:
{

  home.packages = with pkgs; [
    unstable.jetbrains.idea-community
  ];

  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    git = {
      enable = true;
      userName = "abhr-0";
      userEmail = "121384410+abhr-0@users.noreply.github.com";
    };

    neovim = {
      enable = true;
      # plugins = with pkgs.vimPlugins; [

      # ];
    };

    vscode = {
      enable = true;
      package = pkgs.unstable.vscodium;
    };
  };

  # Note: GNOME's seahorse replaces the functionality of ssh, ssh-agent, gpg and gpg-agent
  #
  # programs.gpg.enable = true;
  # services.gpg-agent = {
  #   enable = true;
  #   pinentryPackage = pkgs.pinentry-gnome3;
  # };

  home.sessionVariables = {
    DOCKER_HOST = "unix:///run/user/1000/podman/podman.sock";
    EDITOR = "codium --wait";
  };
}
