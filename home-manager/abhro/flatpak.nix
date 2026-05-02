{ inputs, ... }:
{
  imports = [ inputs.nix-flatpak.homeManagerModules.nix-flatpak ];

  services.flatpak = {
    enable = true;
    packages = [
      "org.videolan.VLC" # Flatpak version works better
      "one.ablaze.floorp"
      "md.obsidian.Obsidian"
    ];

    # uninstallUnmanaged = true;

    update.auto = {
      enable = true;
      onCalendar = "weekly"; # Default value
    };
  };
}
