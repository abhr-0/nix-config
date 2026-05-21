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
          config.settings.nixd =
            let
              flake_path = "(builtins.getFlake (builtins.toString ./.))";
            in
            {
              nixpkgs.expr = "import ${flake_path}.inputs.nixpkgs { } ";
              formatting = { };
              options = {
                nixos.expr = "${flake_path}.nixosConfigurations.laptop.options";
                home_manager.expr = "${flake_path}.nixosConfigurations.laptop.options.home-manager.users.type.getSubOptions []";

                # Need to enable `debug` option in flake-parts for this
                flake-parts.expr = "${flake_path}.debug.options";
                flake-parts-sys.expr = "${flake_path}.currentSystem.options";

                nixvim.expr = "${flake_path}.packages.x86_64-linux.neovim.options";
              };
            };
        };
      };
      keymaps = [
        {
          key = "gd"; # or <C-]> look `:h lsp-defaults`
          lspBufAction = "definition";
        }
        {
          key = "gD";
          lspBufAction = "declaration";
        }
        {
          action = "<CMD>lsp restart<Enter>";
          key = "<leader>l";
          options.desc = "Restart LSP";
        }
      ];
      luaConfig.post = ''
        local severity = vim.diagnostic.severity

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
          jump = { float = true, },
        })
      '';
    };
  };
}
