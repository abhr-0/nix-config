{
  config = {
    # For sane LSP defaults
    plugins.lspconfig.enable = true;

    lsp = {
      inlayHints.enable = true;
      servers = {
        clangd.enable = true;
        basedpyright.enable = true;
        ruff.enable = true;
        nixd = {
          enable = true;
          config.settings.nixd = {
            nixpkgs.expr = "import <nixpkgs> { } ";
            options =
              let
                flake_path = "(builtins.getFlake (builtins.toString ./.))";
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
      };
      keymaps = [
        /*nixfmt:disable*/
        { key = "gd"; lspBufAction = "definition"; options.desc = "Go to definition"; } # or <C-]> look `:h lsp-defaults`
        { key = "gD"; lspBufAction = "declaration"; options.desc = "Go to declaration"; }
        { action = "<CMD>lsp restart<Enter>"; key = "<leader>l"; options.desc = "Restart LSP"; }
        /*nixfmt:enable*/
      ];
      luaConfig.post = ''
        local severity = vim.diagnostic.severity

        local function on_jump(diagnostic, bufnr)
          if not diagnostic then return end
          vim.diagnostic.open_float()
        end

        vim.diagnostic.config({
          signs = {
            text = {
              [severity.ERROR] = " ",
              [severity.WARN] = " ",
              [severity.HINT] = " ",
              [severity.INFO] = " ",
            },
          },
          float = { source = "always", },
          jump = { on_jump = on_jump },
        })
      '';
    };
  };
}
