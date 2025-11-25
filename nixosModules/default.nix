{
  imports = [
    ./desktop/gnome.nix
    ./settings/misc.nix
    ./settings/home-manager.nix
    ./settings/networking.nix
    ./settings/nix.nix
    ./settings/users.nix
    ./security/hardening.nix
    ./security/sops.nix
    ./services/openssh.nix
    ./services/setUserIcons.nix
    ./services/tailscale.nix
    ./services/usbguard.nix
    ./settings/virtualisation.nix
  ];

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";
  time.hardwareClockInLocalTime = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
}
