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

      # https://wiki.nixos.org/wiki/Overlays
      # NOTE: easyOverlay re-evaluates perSystem with `pkgs` bound to the
      # consuming instance (prev), so inheriting its config here makes a host's
      # nixpkgs.config (e.g. allowUnfreePackages) apply to unstablePkgs too.
      overlayAttrs = rec {
        unstablePkgs = import inputs.nixpkgs-unstable {
          inherit system;
          inherit (pkgs) config;
        };

        inherit (unstablePkgs) lazygit;
        inherit (unstablePkgs) yazi;
        inherit (unstablePkgs) vscode;
        inherit (unstablePkgs) opencode;

        localPkgs = config.packages;
      };

      packages = lib.packagesFromDirectoryRecursive {
        inherit (pkgs) callPackage;
        directory = ../../pkgs;
      };
    };
}
