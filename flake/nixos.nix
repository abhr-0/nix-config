{ inputs, lib, ... }:
{
  flake =
    let
      hosts = builtins.attrNames (builtins.readDir ../hosts);
      genNixosConfigurations =
        configurationList: lib.genAttrs configurationList (name: mkNixOS { hostName = name; });
      mkNixOS =
        { hostName }:
        inputs.nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          # > Our main nixos configuration file <
          modules = [
            ../hosts/${hostName}/configuration.nix
            (inputs.import-tree ../modules/nixos)
            {
              nixpkgs.overlays = [ inputs.self.overlays.default ];
              networking = { inherit hostName; };
            }
          ];
        };
    in
    {
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = genNixosConfigurations hosts;
    };
}
