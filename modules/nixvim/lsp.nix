{ lib, ... }:
{
  config = {
    # For sane LSP defaults
    plugins.lspconfig.enable = true;

    autoCmd = [
      {
        event = [ "BufWritePre" ];
        pattern = "*";
        callback = lib.nixvim.mkRaw "function() vim.lsp.buf.format({ async = false }) end";
      }
    ];

    lsp = {
      inlayHints.enable = true;
      servers = {
        clangd.enable = true;
        markdown_oxide.enable = true; # Checkout
        # python: basedpyright and ruff?
        # statix.enable = true;
        nixd = {
          enable = true;
          config.settings.nixd = {
            nixpkgs.expr = /* nix */ "import (builtins.getFlake (builtins.toString ./.)).inputs.nixpkgs { } ";
            formatting = { };
            options = {
              nixos.expr = /* nix */ "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.laptop.options";
              home_manager.expr = /* nix */ "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.laptop.options.home-manager.users.type.getSubOptions []";

              # Need to enable `debug` option in flake-parts for this
              flake-parts.expr = /* nix */ "(builtins.getFlake (builtins.toString ./.)).debug.options";
              flake-parts-sys.expr = /* nix */ "(builtins.getFlake (builtins.toString ./.)).currentSystem.options";

              nixvim.expr = /* nix */ "(builtins.getFlake (builtins.toString ./.)).packages.x86_64-linux.neovim.options";
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
          action = lib.nixvim.mkRaw "function() vim.diagnostic.jump({ count=-1, float=true }) end";
          key = "<leader>k";
          options.desc = "Prev Diagonistic";
        }
        {
          action = lib.nixvim.mkRaw "function() vim.diagnostic.jump({ count=1, float=true }) end";
          key = "<leader>j";
          options.desc = "Next Diagonistic";
        }
        {
          action = "<CMD>lsp restart<Enter>";
          key = "<leader>l";
          options.desc = "Restart LSP";
        }
        # {
        #   action = lib.nixvim.mkRaw "require('telescope.builtin').lsp_definitions";
        #   key = "gd";
        # }
        # {
        #   action = "<CMD>Lspsaga hover_doc<Enter>";
        #   key = "K";
        # }
      ];
    };

  };
}
