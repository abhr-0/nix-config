{ pkgs, ... }:

{
  # GNOME Configuration
  programs.gnome-shell = {
    enable = true;

    extensions = with pkgs.gnomeExtensions; [
      {
        id = "AlphabeticalAppGrid@stuarthayhurst";
        package = alphabetical-app-grid;
      }
      {
        id = "appindicatorsupport@rgcjonas.gmail.com";
        package = appindicator;
      }
      {
        id = "clipboard-indicator@tudmotu.com";
        package = clipboard-indicator;
      }
      {
        id = "dash-to-dock@micxgx.gmail.com";
        package = dash-to-dock;
      }
    ];
  };

  dconf = {
    enable = true;

    settings = {
      # Set dark mode
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";

      # Display all folders at the end of the app grid
      "org/gnome/shell/extensions/alphabetical-app-grid".folder-order-position = "end";

      # USB protection settings
      "org/gnome/desktop/privacy" = {
        usb-protection = "true";
        # - 'lockscreen' rejects all new USB only when the lock screen is present
        # - 'always' rejects all new USB devices, when using this, to temporarily
        # allow USB devices use: `sudo usbguard set-parameter ImplicitPolicyTarget allow`
        usb-protection-level = "lockscreen";
      };

      # Wallpaper
      "org/gnome/desktop/background" = {
        picture-uri = "file://${./wallpaper.png}";
        picture-uri-dark = "file://${./wallpaper.png}";
      };
    };
  };

  # Set cursor to "Bibata Modern Classic"
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 32;
    x11.enable = true;
    gtk.enable = true;
  };

  gtk.enable = true; # Required by home.pointerCursor.gtk.enable = true to work correctly
}
