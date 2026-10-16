{ inputs, lib, ... }:
{
  imports = [ inputs.flake-parts.flakeModules.easyOverlay ];
  perSystem =
    {
      config,
      pkgs,
      system,
      ... # final for overlay
    }:
    {
      # NOTE: Look into ./nixvim.nix as nixvim likes to manage its own pkgs.

      overlayAttrs = rec {
        unstablePkgs = import inputs.nixpkgs-unstable {
          inherit system;
          # TODO: Find solution as I cannot customize nixpkgs in home-manager as: `useGlobalPackages = true`
          config.allowUnfreePackages = [ "vscode" ];
        };

        inherit (unstablePkgs) lazygit;
        inherit (unstablePkgs) yazi;
        inherit (unstablePkgs) vscode;

        localPkgs = config.packages;
      };

      packages = lib.packagesFromDirectoryRecursive {
        inherit (pkgs) callPackage;
        directory = ../pkgs;
      };
    };
}
