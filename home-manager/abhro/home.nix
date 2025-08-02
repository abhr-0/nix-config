{
  imports = [
    ./fonts.nix
    ./gnome.nix
    ./programs/apps.nix
    ./programs/cli.nix
    ./programs/dev.nix
    ./services/flatpak.nix
    ./programs/nix.nix
    ./programs/zsh.nix
  ];

  # Set username
  home = {
    username = "abhro";
    homeDirectory = "/home/abhro";
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
