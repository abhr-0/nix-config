{
  # HACK: WORKAROUND: systemd 260.5 + libcryptsetup token plugins retry a wrong TPM2
  # PIN indefinitely instead of falling back to the LUKS passphrase.
  # crypt_activate_by_token_pin_ask_password() keeps looping while the token
  # returns -ENOANO, and systemd's systemd-tpm2 plugin returns -ENOANO for a
  # bad PIN. It only gives up when the TPM enters DA lockout (-ENOLCK), which
  # on this machine takes 32 attempts.
  #
  # Force systemd's built-in TPM2 implementation instead, which caps PIN
  # attempts at 5 and returns -EACCES so systemd-cryptsetup falls back to the
  # passphrase.
  #
  # Upstream:
  # - https://github.com/systemd/systemd/issues/32041
  # - https://github.com/systemd/systemd/issues/39049
  # Remove once a crypttab option for TPM2 PIN retries is available.
  boot.initrd = {
    luks.devices."cryptroot".crypttabExtraOpts = [
      "tpm2-device=auto"
      "tpm2-pin=yes"
    ];
    systemd.services."systemd-cryptsetup@cryptroot" = {
      # This unit is generated at boot from /etc/crypttab, so it must be a
      # drop-in; a full unit file would shadow the generated unit.
      overrideStrategy = "asDropin";
      # Upstream debug switch that bypasses the libcryptsetup token plugin:
      # https://github.com/systemd/systemd/blob/v260.5/src/cryptsetup/cryptsetup.c
      environment.SYSTEMD_CRYPTSETUP_USE_TOKEN_MODULE = "0";
    };
  };
}
