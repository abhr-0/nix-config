{ inputs, lib, ... }:
{
  imports = [ inputs.flake-parts.flakeModules.easyOverlay ];
  perSystem = { config, system, ... }: {
    # NOTE: Look into ./nixvim.nix as nixvim likes to manage its own pkgs.

    overlayAttrs = rec {
      unstablePkgs = import inputs.nixpkgs-unstable {
        inherit system;
        # TODO: Find solution as I cannot customize nixpkgs in home-manager as: `useGlobalPackages = true`
        config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "vscode" ];
      };

      inherit (unstablePkgs) lazygit;
      inherit (unstablePkgs) vscode;

      localPkgs = {
        inherit (config.packages) neovim;
        inherit (config.packages) bitwarden-polkit-policy;
      };
    };
  };
}
