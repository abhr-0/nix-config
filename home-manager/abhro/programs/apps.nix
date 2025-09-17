{ pkgs, ... }:
{
  # GUI Applications
  home.packages = with pkgs; [
    /*
      Privacy & Security
      ------------------
    */
    authenticator # TOTP provider
    bitwarden-desktop # Bitwarden Desktop Client
    protonvpn-gui # VPN
    # torbrowser-launcher
    vaults # Encrypted vaults

    /*
      Multimedia
      ----------
    */
    # gimp
    # handbrake # For transcoding videos
    # libreoffice-fresh # Office Suite

    /*
      Miscellaneous
      -------------
    */
    # jabref # References Manager
    # zotero # References Manager
    pika-backup # Backup
    vorta # Backup "GTK_THEME" = "Adwaita:dark"; # Force dark mode also icon problem: https://github.com/NixOS/nixpkgs/issues/353568

    /*
      Utilities
      ---------
    */
    eyedropper # Color picker
    fragments # Torrent Client
    # gnome-frog # OCR Reader
    hieroglyphic # Tool to find LaTeX symbols
    # junction # App picker
    localsend
    # mangohud
    pdfarranger
    # pods # Podman GUI Frontend
    # share-preview
    # textpieces
    # raider # File shredder
  ];

  programs.ghostty = {
    enable = true;
    settings = {
      theme = "Adwaita Dark";
      font-family = "FiraCode Nerd Font";
      font-size = 14;
    };
  };
}
