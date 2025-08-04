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

    helix = {
      enable = true;

      # languages = {
      #   nix = {
      #     formatter.command = "nixfmt";
      #     auto-format = true;
      #   };
      #   language-server.nixd = {
      #     command = "nixd";
      #     formatting = {
      #       command = [
      #         "nix"
      #         "fmt"
      #         "--"
      #         "-"
      #       ];
      #     };
      #     nixpkgs.expr = "import (builtins.getFlake (\"git+file://\" + toString ./.)).inputs.nixpkgs { }";
      #     options = {
      #       nixos.expr = "(builtins.getFlake (\"git+file://\" + toString ./.)).nixosConfigurations.laptop.options";
      #       home_manager.expr = "(builtins.getFlake (\"git+file://\" + toString ./.)).homeConfigurations.abhro@laptop.options";
      #     };
      #   };
      #   language-server.nil = {
      #     command = "nil";
      #     formatting = {
      #       command = [
      #         "nix"
      #         "fmt"
      #         "--"
      #         "-"
      #       ];
      #     };
      #   };
      # };
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
