{ self, inputs, ... }:
{
  perSystem =
    { system, ... }:
    let
      nixvimLib = inputs.nixvim.lib.${system};
      nixvim' = inputs.nixvim.legacyPackages.${system};
      nixvimModule = {
        inherit system; # or alternatively, set `pkgs`
        module = inputs.import-tree ../nixvim; # import the module directly
        # You can use `extraSpecialArgs` to pass additional arguments to your module files
        extraSpecialArgs = {
          # inherit (inputs) foo;
          inherit self;
        };
      };
      nvim = nixvim'.makeNixvimWithModule nixvimModule;
    in
    {
      # Run `nix flake check .` to verify that your config is not broken
      checks.neovim = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;

      # Lets you run `nix run .` to start nixvim
      packages.neovim = nvim;
    };
}
