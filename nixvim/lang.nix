{ lib, ... }:
{
  files =
    lib.concatMapAttrs
      (lang: localOpts: {
        "ftplugin/${lang}.lua" = { inherit localOpts; };
      })
      {
        python.colorcolumn = lib.mkForce [ "88" ];
      };
}
