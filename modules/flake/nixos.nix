{
  self,
  inputs,
  lib,
  ...
}:
{
  flake =
    let
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
      nixosConfigurations = genNixosConfigurations [
        "desktop"
        "laptop"
      ];

      nixosModules.default = ../../modules/nixos/default.nix;
    };
}
