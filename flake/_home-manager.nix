# NOTE: Not used in current config, but can be used for standalone home-manager in the future.
# NOTE: Currently in the format of just `<username>`, can also be `<username>@<hostname>`
{ inputs, ... }:
{
  imports = [ inputs.home-manager.flakeModules.home-manager ];

  flake = {
    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#abhro'
    homeConfigurations."abhro" = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import inputs.nixpkgs {
        system = "x86_64-linux";
        overlays = [ inputs.self.overlays.default ];
      };
      extraSpecialArgs = { inherit inputs; };
      # > Our main home-manager configuration file <
      modules = [
        ../home-manager/abhro/home.nix
        # Only needed for standalone HM; the NixOS and nix-darwin modules
        # derive these from users.users.<name>.
        {
          home = {
            username = "abhro";
            homeDirectory = "/home/abhro";
          };
        }
      ];
    };
  };
}
