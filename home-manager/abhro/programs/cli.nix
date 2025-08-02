{
  lib,
  pkgs,
  ...
}:
{
  # CLI programs
  programs = {
    # bat = {
    #   enable = true;
    #   config = {
    #     # Show line numbers, git modifications, file header and grid
    #     style = "full";
    #     theme = "base16";
    #   };
    # };

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

    yazi = {
      enable = true;
      settings.manager.ratio = [
        2
        4
        4
      ];
    };

    zoxide.enable = true;
  };

  # home.packages = with pkgs; [
  #   tlrc   # Rust client for TLDR
  #   pandoc    # Document type converter
  #   kondo     # project garbage cleaner
  # ];
}
