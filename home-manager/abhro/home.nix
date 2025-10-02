{
  imports = [
    ./fonts.nix
    ./gnome.nix
    ./sops.nix
    ./programs/apps.nix
    ./programs/dev.nix
    ./programs/zsh.nix
    ./services/flatpak.nix
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
