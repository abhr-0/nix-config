{ pkgs, ... }:
{
  i18n = {
    defaultLocale = "en_US.UTF-8"; # en_IN
    # extraLocales = [ ];

    # Enable ibus for multi-lingual input
    inputMethod = {
      enable = true;
      type = "ibus";
      ibus.engines = [ pkgs.ibus-engines.m17n ]; # no input setup ?
    };
  };
}
