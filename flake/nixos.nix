{
  self,
  inputs,
  lib,
  ...
}:
{
  flake =
    let
      hosts = builtins.attrNames (builtins.readDir ../hosts);
      genNixosConfigurations =
        configurationList: lib.genAttrs configurationList (name: mkNixOS { hostName = name; });
      mkNixOS =
        { hostName }:
        inputs.nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs self; };
          # > Our main nixos configuration file <
          modules = [
            ../hosts/${hostName}/configuration.nix
            (inputs.import-tree ../nixosModules)
            {
              nixpkgs.overlays = [ self.overlays.default ];
              sops.secrets.usbguard_rules_file.sopsFile = ../secrets/${hostName}.yaml;
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
