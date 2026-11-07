{
  config = {
    # For sane LSP defaults
    plugins.lspconfig.enable = true;

    lsp = {
      inlayHints.enable = true;
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
