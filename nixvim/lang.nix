{ lib, ... }:
{
  files =
    lib.concatMapAttrs
      (lang: localOpts: {
        "ftplugin/${lang}.lua" = { inherit localOpts; };
      })
      {
        nix.colorcolumn = [ "80" ];
      };
}
