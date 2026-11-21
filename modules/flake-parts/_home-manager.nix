# NOTE: Inactive by default; rename to `home-manager.nix` to expose standalone
# Home Manager hosts. Any hosts/<hostName>/ holding a home.nix gets a
# homeConfigurations."<username>@<hostName>", whether or not it also has a
# configuration.nix (i.e. standalone HM on a NixOS host). In that case set
# systemSettings.home-manager.enable = false so both don't manage ~/.config.
{ inputs, lib, ... }:
{
  flake =
    let
      hosts = builtins.attrNames (builtins.readDir ../../hosts);
      standaloneHosts = builtins.filter (
        hostName: builtins.pathExists ../../hosts/${hostName}/home.nix
      ) hosts;

      username = "abhro"; # single-user repo; also the <username> in the output key

      genHomeConfigurations =
        hostList:
        builtins.listToAttrs (
          map (
            hostName:
            lib.nameValuePair "${username}@${hostName}" (mkHome {
              inherit hostName;
            })
          ) hostList
        );
      mkHome =
        { hostName }:
        inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = import inputs.nixpkgs {
            system = "x86_64-linux";
            # Same overlay as the NixOS hosts, so localPkgs/unstablePkgs resolve.
            overlays = [ inputs.self.overlays.default ];
          };
          extraSpecialArgs = { inherit inputs; };
          modules = [
            (inputs.import-tree ../home-manager)
            ../../hosts/${hostName}/home.nix
            # No users.users here, so derive these the way nixos.nix sets
            # networking.hostName. A host home.nix can still override them.
            {
              home = {
                inherit username;
                homeDirectory = "/home/${username}";
              };
            }
          ];
        };
    in
    {
      # Available through 'home-manager switch --flake .#<username>@<hostName>'
      homeConfigurations = genHomeConfigurations standaloneHosts;
    };
}
