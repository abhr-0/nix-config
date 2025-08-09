{
  imports = [
    ./desktop/gnome.nix
    ./desktop/misc.nix
    ./settings/networking.nix
    ./settings/nix.nix
    ./settings/users.nix
    ./security/hardening.nix
    ./security/sops.nix
    ./services/openssh.nix
    ./services/setUserIcons.nix
    ./services/usbguard.nix
    ./settings/virtualization.nix
  ];

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";
  time.hardwareClockInLocalTime = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
}
