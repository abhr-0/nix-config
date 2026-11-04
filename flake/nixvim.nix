{ inputs, ... }:
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
              source = inputs.nixpkgs-unstable; # WARN: Can cause issues, try disabling if nixvim fails to build (Also set in flake.nix)
              overlays = [ nixvim-overlay ];
              config.allowUnfreePackages = [ "copilot-language-server" ]; # FIXME: nixvim
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
