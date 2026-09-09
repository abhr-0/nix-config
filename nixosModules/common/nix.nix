{ self, inputs, ... }:
{
  nix = {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Opinionated: disable global registry
      flake-registry = "";

      auto-optimise-store = true;
    };
    # Opinionated: disable channels
    channel.enable = false;
    registry.nixpkgs-unstable.flake = inputs.nixpkgs-unstable;
  };

  nixpkgs.overlays = [ self.overlays.unstable ];

  programs.nix-ld.enable = true;
  #services.envfs.enable = true;
}
