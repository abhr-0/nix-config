{
  lib,
  pkgs,
  ...
}:
{
  # CLI programs
  programs = {
    # eza = {
    #   enable = true;
    #   icons = "always"; # Always show icons
    #   git = true; # Display git status of each file (only in long format)
    # };

    fd.enable = true;

    fzf = rec {
      enable = true;
      changeDirWidgetCommand = "${pkgs.fd}/bin/fd --type d --hidden --strip-cwd-prefix --exclude .git";
      defaultCommand = "${pkgs.fd}/bin/fd --hidden --strip-cwd-prefix --exclude .git";
      fileWidgetCommand = defaultCommand;
    };

    ripgrep.enable = true;

    starship = {
      enable = true;
      settings = (lib.modules.importTOML ./starship.toml).config; # Import settings from starship.toml
    };

    zoxide.enable = true;

    zsh = {
      enable = true; # Must explicity include for direnv and starship

      autosuggestion.enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      historySubstringSearch = {
        enable = true;
        searchUpKey = [ "$terminfo[kcuu1]" ];
        searchDownKey = [ "$terminfo[kcud1]" ];
        # Ctrl+U aborts the search
      };

      history = {
        ignoreAllDups = true;
        ignoreDups = true;
        ignoreSpace = true;
      };

      defaultKeymap = "viins";
    };

  };

  # home.packages = with pkgs; [
  #   tlrc   # Rust client for TLDR
  #   pandoc    # Document type converter
  #   kondo     # project garbage cleaner
  # ];
}
