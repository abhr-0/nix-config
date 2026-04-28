{
  imports = [
    ./desktop/gnome.nix
    ./security/hardening.nix
    ./security/sops.nix
    ./services/firewalld.nix
    ./services/openssh.nix
    ./services/setUserIcons.nix
    ./services/tailscale.nix
    ./services/usbguard.nix
    ./settings/home-manager.nix
    ./settings/misc.nix
    ./settings/networking.nix
    ./settings/nh.nix
    ./settings/nix.nix
    ./settings/users.nix
    ./settings/virtualisation.nix
  ];

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";
  time.hardwareClockInLocalTime = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
}
