{
  config,
  pkgs,
  lib,
  inputs,
  hostName,
  ...
}:
{
  imports = [ inputs.nix-index-database.homeModules.nix-index ];

  home.packages =
    with pkgs;
    (
      [
        ollama
        nixd
        nixfmt-rfc-style
        # vulnix
      ]
      ++ lib.optional (hostName == "laptop") unstable.jetbrains.idea-oss
    );

  programs = {
    nix-index-database.comma.enable = true;

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    neovim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [
        {
          plugin = nvim-surround;
          config = "lua require('nvim-surround').setup()";
        }
      ]; # Note: relative line numbering not working with VSCode Neovim ext
      extraLuaConfig = lib.readFile ./neovimCfg.lua;
      extraPackages = [ pkgs.wl-clipboard ]; # For clipboard syncing with OS
    };

    vscode = {
      enable = true;
      package = pkgs.unstable.vscode;
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
    EDITOR = "${config.programs.vscode.package}/bin/code --wait";
  };
}
