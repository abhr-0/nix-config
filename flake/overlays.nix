{
  self,
  inputs,
  lib,
  ...
}:
{
  flake.overlays = rec {
    nixvim = final: prev: {
      vimPlugins = prev.vimPlugins.extend (
        _: _: {
          # final' and prev'
          # Not in nixpkgs
          blink-cmp-copilot-chat = final.callPackage ../pkgs/blink-cmp-copilot-chat.nix { };
        }
      );
    };

    unstable-packages = final: _prev: {
      unstable = import inputs.nixpkgs-unstable {
        inherit (final.stdenv.hostPlatform) system;
        # TODO: Find solution as I cannot customize nixpkgs in home-manager as:
        # useGlobalPackages = true
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
        bitwarden-polkit-policy = final.callPackage ../pkgs/bitwarden-polkit-policy.nix { };
      };
    };
  };
}
