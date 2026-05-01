{ pkgs, ... }:
{
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocales = [ "en_IN/UTF-8" ];

    # Enable ibus for multi-lingual input
    inputMethod = {
      enable = true;
      type = "ibus";
      ibus.engines = [ pkgs.ibus-engines.m17n ]; # no input setup ?
    };
  };
}
