{ inputs, lib, ... }:
{
  perSystem =
    { config, system, ... }:
    let
      nixvim-overlay = _final: prev: {
        vimPlugins = prev.vimPlugins.extend (
          # final' and prev'
          _: _: { inherit (config.packages) blink-cmp-copilot-chat; } # Not in nixpkgs
        );
      };
      configuration = inputs.nixvim.lib.evalNixvim {
        inherit system;
        modules = [
          (inputs.import-tree ../nixvim)
          {
            nixpkgs = {
              overlays = [ nixvim-overlay ];
              config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "copilot-language-server" ]; # FIXME: nixvim
            };
          }
        ];
        # extraSpecialArgs
      };
    in
    {
      # Run `nix flake check .#neovim` to verify that your config is not broken
      checks.neovim = configuration.config.build.test;

      # Lets you run `nix run .#neovim` to start nixvim
      packages.neovim = configuration.config.build.package;
    };
}
