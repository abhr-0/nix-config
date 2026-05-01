{ inputs, ... }:
{
  imports = [ inputs.home-manager.flakeModules.home-manager ];

  flake = {
    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations."abhro" = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages."x86_64-linux"; # Home-manager requires 'pkgs' instance
      extraSpecialArgs = { inherit inputs; };
      # > Our main home-manager configuration file <
      modules = [ ../../home-manager/abhro/home.nix ];
    };
  };
}
