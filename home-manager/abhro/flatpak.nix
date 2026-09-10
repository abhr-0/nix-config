{ inputs, ... }:
{
  imports = [ inputs.nix-flatpak.homeManagerModules.nix-flatpak ];

  services.flatpak = {
    enable = true;
    packages = [
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
