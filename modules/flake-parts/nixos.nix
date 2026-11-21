{ inputs, lib, ... }:
{
  flake =
    let
      hosts = builtins.attrNames (builtins.readDir ../../hosts);

      # A hosts/ entry with configuration.nix is a NixOS host. It may also carry
      # home.nix (the machine's standalone HM entrypoint, see _home-manager.nix);
      # the two outputs are independent.
      nixosHosts = builtins.filter (
        hostName: builtins.pathExists ../../hosts/${hostName}/configuration.nix
      ) hosts;

      genNixosConfigurations =
        configurationList: lib.genAttrs configurationList (name: mkNixOS { hostName = name; });
      mkNixOS =
        { hostName }:
        inputs.nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          # > Our main nixos configuration file <
          modules = [
            ../../hosts/${hostName}/configuration.nix
            (inputs.import-tree ../nixos)
            {
              nixpkgs.overlays = [ inputs.self.overlays.default ];
              networking = { inherit hostName; };
            }
          ];
        };
    in
    {
      # Available through 'nixos-rebuild --flake .#<hostName>'
      nixosConfigurations = genNixosConfigurations nixosHosts;
    };
}
