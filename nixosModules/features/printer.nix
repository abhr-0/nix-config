{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.systemSettings.printer;
in
{
  options.systemSettings.printer.enable = lib.mkEnableOption "Enable printer and scanner support";

  config = lib.mkIf cfg.enable {
    nixpkgs.config.allowUnfreePackages = [
      "hplip"
      "hplipWithPlugin"
    ];

    services.printing = {
      enable = true;
      drivers = [ pkgs.hplipWithPlugin ];
    };

    # Enable SANE to scan documents.
    hardware.sane = {
      enable = true;
      extraBackends = [ pkgs.hplipWithPlugin ];
    };
  };
}
