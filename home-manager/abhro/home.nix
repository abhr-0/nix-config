{
  config,
  inputs,
  pkgs,
  hostName,
  ...
}:
{
  imports = [ inputs.nix-index-database.homeModules.nix-index ];

  home = {
    username = "abhro";
    homeDirectory = "/home/abhro";

    # GUI Applications
    packages = with pkgs; [
      # Privacy & Security
      authenticator # TOTP provider
      bitwarden-desktop # Bitwarden Desktop Client
      proton-vpn # VPN
      # torbrowser-launcher
      vaults # Encrypted vaults

      # Multimedia
      vlc # Media Player
      # gimp
      # handbrake # For transcoding videos
      # libreoffice-fresh # Office Suite

      # Miscellaneous
      pika-backup # Backup
      # vorta # Backup "GTK_THEME" = "Adwaita:dark"
      en-croissant # Chess GUI

      # Utilities
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

      # Various Tools
      localPackages.neovim # Neovim with custom config
      ollama # LLM runtime
      nixd # Nix LSP Server
      nixfmt # Nix Formatter
      # vulnix
      # distrobox

      nerd-fonts.fira-code # Used by ghostty, starship & VSCodium configs
      nerd-fonts.caskaydia-cove
      nerd-fonts.jetbrains-mono
      noto-fonts
      roboto
      source-sans
      ibm-plex
      inter
    ];

    sessionVariables.EDITOR = "nvim";
    # shellAliases.vimdiff = "nvim -d";

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "24.11";
  };

  programs = {
    firefox = {
      enable = true;
      configPath = "${config.xdg.configHome}/mozilla/firefox";
      package = pkgs.firefox.override {
        nativeMessagingHosts = [ pkgs.gnome-browser-connector ]; # Gnome shell native connector
      };
    };

    nix-index-database.comma.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    vscode.enable = hostName == "earth";
  };

  # Load fonts
  fonts.fontconfig.enable = true;
}
