{
  self,
  inputs,
  lib,
  ...
}:
{
  flake =
    let
      hosts = builtins.attrNames (builtins.readDir ../../hosts);
      genNixosConfigurations =
        configurationList: lib.genAttrs configurationList (name: mkNixOS { hostName = name; });
      mkNixOS =
        { hostName }:
        inputs.nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs hostName; };
          # > Our main nixos configuration file <
          modules = [
            ../../hosts/${hostName}/configuration.nix
            self.nixosModules.default
          ];
        };
    in
    {
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = genNixosConfigurations hosts;

      nixosModules.default = ../../modules/nixos/default.nix;
    };
}
