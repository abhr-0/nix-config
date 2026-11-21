{
  config,
  inputs,
  lib,
  ...
}:
let
  cfg = config.systemSettings.home-manager;
in
{
  # Imported unconditionally so `home-manager.users` exists even on hosts that
  # don't enable it; the option below decides whether anything is attached.
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  options.systemSettings.home-manager.enable = lib.mkEnableOption "Home Manager as a NixOS module";

  config = lib.mkIf cfg.enable {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      sharedModules = [ ];
      extraSpecialArgs = { inherit inputs; };
    };
  };
}
