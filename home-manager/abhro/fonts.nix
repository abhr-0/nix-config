{ pkgs, ... }:
{
  # Font Configuration
  home.packages = with pkgs; [
    nerd-fonts.fira-code # Used by ghostty, starship & VSCodium configs
    nerd-fonts.caskaydia-cove
    nerd-fonts.jetbrains-mono
    noto-fonts
  ];

  # Load fonts
  fonts.fontconfig.enable = true;
}
