{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.systemSettings.fprint.enable = lib.mkEnableOption "Enable fingerprint reader support";

  config = lib.mkIf config.systemSettings.fprint.enable {
    nixpkgs.config.allowUnfreePackages = [ "libfprint-2-tod1-elan" ];

    services.fprintd = {
      enable = true;
      package = pkgs.fprintd-tod;
      tod.enable = true;
      tod.driver = pkgs.libfprint-2-tod1-elan;
    };
  };
}
