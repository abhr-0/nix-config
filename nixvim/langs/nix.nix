{
  config = {
    lsp.servers.nixd = {
      enable = true;
      config.settings.nixd = {
        nixpkgs.expr = "import <nixpkgs> { } ";
        options =
          let
            flake_path = "(builtins.getFlake (builtins.toString ./.))"; # FIXME: Use `self`?
          in
          {
            nixos.expr = "${flake_path}.nixosConfigurations.earth.options"; # FIXME: Get hostname? using either getEnv or readFile

            # For HM as NixOS module
            home-manager.expr = "${flake_path}.nixosConfigurations.earth.options.home-manager.users.type.getSubOptions []";

            # For standalone HM:
            # home_manager.expr = "${flake_path}.homeConfigurations.<name>.options"

            # Need to enable `debug` option in flake-parts for this
            # flake-parts.expr = "${flake_path}.debug.options";
            # flake-parts-sys.expr = "${flake_path}.currentSystem.options";

            # NOTE: `builtins.currentSystem` is evaluated by nixd.
            # `pkgs.stdend.hostPlatform.system` is not needed here as nixd
            # can just use the "system" it's running on
            nixvim.expr = "${flake_path}.packages.\${builtins.currentSystem}.neovim.options";
          };
      };
    };
    plugins.conform-nvim.settings.formatters_by_ft.nix = [ "nix fmt" ];
  };
}
