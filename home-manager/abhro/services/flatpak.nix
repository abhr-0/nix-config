{ inputs, ... }:
{
  imports = [ inputs.nix-flatpak.homeManagerModules.nix-flatpak ];

  services.flatpak = {
    enable = true;
    packages = [
      "io.github.kolunmi.Bazaar"
      "org.videolan.VLC" # Flatpak version works better
      "one.ablaze.floorp"
      "md.obsidian.Obsidian"
      "org.libreoffice.LibreOffice"
    ];

    # uninstallUnmanaged = true;

    update.auto = {
      enable = true;
      onCalendar = "weekly"; # Default value
    };
  };
}
