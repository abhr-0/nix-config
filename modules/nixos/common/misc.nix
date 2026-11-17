{ pkgs, ... }: {
  i18n = {
    defaultLocale = "en_IN";
    extraLocales = [ "en_US.UTF-8/UTF-8" ];
  };

  services.flatpak.enable = true;

  programs.appimage.binfmt = true;

  zramSwap.enable = true;

  environment.systemPackages = with pkgs; [
    localPkgs.bitwarden-polkit-policy
  ];
}
