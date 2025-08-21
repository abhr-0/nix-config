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
      plugins =
        let
          vscode-multi-cursor = pkgs.vimUtils.buildVimPlugin {
            name = "vscode-multi-cursor";
            src = pkgs.fetchFromGitHub {
              owner = "vscode-neovim";
              repo = "vscode-multi-cursor.nvim";
              rev = "210d64a6d190383a81b8dcdf8779d357006f3a69";
              sha256 = "sha256-0o0aiWY7AdtSo4nCfq3fGj0PEfngLgOnK/Y6NTWPWzU=";
            };
          };
        in
        [
          {
            plugin = vscode-multi-cursor;
            config = "require('vscode-multi-cursor').setup()";
          }
        ];
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
