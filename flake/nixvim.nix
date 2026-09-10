{
  self,
  inputs,
  lib,
  ...
}:
{
  perSystem =
    { system, ... }:
    let
      configuration = inputs.nixvim.lib.evalNixvim {
        inherit system;
        modules = [
          (inputs.import-tree ../nixvim)
          {
            nixpkgs = {
              overlays = [ self.overlays.nixvim ];
              config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "copilot-language-server" ]; # FIXME: nixvim
            };
          }
        ];
      };
    in
    {
      # Run `nix flake check .` to verify that your config is not broken
      checks.neovim = configuration.config.build.test;

      # Lets you run `nix run .` to start nixvim
      packages.neovim = configuration.config.build.package;
    };
}
