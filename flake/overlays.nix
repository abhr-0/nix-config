{
  self,
  inputs,
  lib,
  ...
}:
{
  flake.overlays = rec {
    # NOTE: Look into ./nixvim.nix as nixvim likes to manage its own pkgs.

    unstable-packages = final: _prev: {
      unstable = import inputs.nixpkgs-unstable {
        inherit (final.stdenv.hostPlatform) system;
        # TODO: Find solution as I cannot customize nixpkgs in home-manager as: `useGlobalPackages = true`
        config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "vscode" ];
      };
    };

    modifications = final: prev: {
      inherit ((unstable-packages final prev).unstable) lazygit;
      inherit ((unstable-packages final prev).unstable) vscode;
    };

    additions = final: _prev: {
      localPackages = {
        inherit (self.packages."${final.stdenv.hostPlatform.system}") neovim;
        inherit (self.packages."${final.stdenv.hostPlatform.system}") bitwarden-polkit-policy;
      };
    };
  };
}
