{ lib, pkgs, ... }:
{
  # Enable the GNOME Desktop Environment.
  services = {
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };

    desktopManager.gnome.enable = true;

    # Set GNOME as the default session
    displayManager.defaultSession = "gnome";
  };

  environment = {
    # Remove GNOME's unneeded packages
    gnome.excludePackages = with pkgs; [
      geary
      yelp
      gnome-software
      gnome-tour
      epiphany
    ];
    systemPackages = [
      pkgs.bibata-cursors
    ] # For Bibata Cursor in GDM
    ++ (with pkgs.gst_all_1; [
      # GStreamer
      gstreamer
      gst-plugins-base
      gst-plugins-good
      gst-plugins-bad
      gst-plugins-ugly
      gst-libav
      gst-vaapi
    ]); # Manually added to ensure symlinks to '/run/current-system/sw/lib/gstreamer-1.0/'
    # Read https://wiki.nixos.org/wiki/GStreamer#nautilus:_%22Your_GStreamer_installation_is_missing_a_plug-in.%22 for more info

    # Needed for nautilus to display 'Audio and Video Properties'
    sessionVariables."GST_PLUGIN_PATH" = "/run/current-system/sw/lib/gstreamer-1.0/";
  };

  # Set cursor to 'Bibata Modern Classic' in GDM
  programs.dconf = {
    enable = true;

    profiles.gdm.databases = [
      {
        lockAll = true;
        settings."org/gnome/desktop/interface" = {
          cursor-theme = "Bibata-Modern-Classic"; # Needs bibata-cursors installed
          cursor-size = lib.gvariant.mkInt32 32;
        };
      }
    ];
  };

  # Enable ibus for multi-lingual input
  i18n.inputMethod = {
    enable = true;
    type = "ibus";
    ibus.engines = [ pkgs.ibus-engines.m17n ];
  };

  # Enable sound
  # WARNING: DO NOT USE `sound.enable = true` as it will setup ALSA;
  security.rtkit.enable = true; # Recommended
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable fwupd (Needed by gnome-firmware)
  # services.fwupd.enable = true;
}
