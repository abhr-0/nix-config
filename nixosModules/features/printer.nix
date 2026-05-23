{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.systemSettings.printer.enable = lib.mkEnableOption "Enable printer and scanner support";

  config = lib.mkIf config.systemSettings.printer.enable {
    nixpkgs.config = {
      allowUnfreePredicate =
        pkg:
        builtins.elem (lib.getName pkg) [
          "hplip"
          "hplipWithPlugin"
        ];
    };

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
