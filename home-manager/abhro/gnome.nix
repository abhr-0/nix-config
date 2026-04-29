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

      # Pin apps to Dash/Dock
      "org/gnome/shell".favorite-apps = [
        "firefox.desktop"
        "org.gnome.Console.desktop"
        "code.desktop"
        "md.obsidian.Obsidian.desktop"
        "org.gnome.Nautilus.desktop"
      ];

      # Custom keyboard shortcut
      "org/gnome/settings-daemon/plugins/media-keys".custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" # / is critical?
      ];

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        name = "Launch Console";
        command = "kgx";
        binding = "<Super>t";
      };

      # Configure Dash-to-Dock
      "org/gnome/shell/extensions/dash-to-dock" = {
        # Disable trash in dock
        # show-trash = false;

        # Set Dash/Dock icon size
        # dash-max-icon-size = 56; # or try, 64
      };

      # USB protection settings
      "org/gnome/desktop/privacy" = {
        usb-protection = "true";
        # - "lockscreen" rejects all new USB only when the lock screen is present
        # - "always" rejects all new USB devices, when using this, to temporarily
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
