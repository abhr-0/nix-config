{
  # Enable Flatpak Support
  services.flatpak.enable = true;

  # Appimage support
  programs.appimage.binfmt = true;

  # Enable zram
  zramSwap.enable = true;
}
