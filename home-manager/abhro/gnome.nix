{ pkgs, ... }:
{
  # GNOME Configuration
  programs.gnome-shell = {
    enable = true;

    extensions = map (package: { inherit package; }) (
      with pkgs.gnomeExtensions;
      [
        alphabetical-app-grid
        appindicator
        clipboard-indicator
        dash-to-dock
        blur-my-shell
        gsconnect
      ]
    );
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
        "com.mitchellh.ghostty.desktop"
        "code.desktop"
        "md.obsidian.Obsidian.desktop"
        "org.gnome.Nautilus.desktop"
        "org.gnome.Software.desktop"
      ];

      # Custom keyboard shortcut
      "org/gnome/settings-daemon/plugins/media-keys".custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" # / is critical?
      ];

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        name = "Launch Ghostty";
        command = "ghostty +new-window";
        binding = "<Super>t";
      };

      # Configure Dash-to-Dock
      "org/gnome/shell/extensions/dash-to-dock" = {
        # Disable trash in dock
        # show-trash = false;

        # Set Dash/Dock icon size
        # dash-max-icon-size = 56; # or try, 64

        disable-overview-on-startup = true;
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
      # "org/gnome/desktop/background" = rec {
      #   picture-uri = "file://${./home-manager/${config.home.username}/wallpaper.png}";
      #   picture-uri-dark = picture-uri;
      # };
    };
  };

  # Set cursor to "Bibata Modern Classic"
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
    x11.enable = true;
    gtk.enable = true;
  };

  gtk.enable = true; # Required by home.pointerCursor.gtk.enable = true to work correctly
}
