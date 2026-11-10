{ lib, ... }: {
  config = {
    # For sane LSP defaults
    plugins.lspconfig.enable = true;

    lsp = {
      inlayHints.enable = true;
      keymaps = [
        /*nixfmt:disable*/
        { key = "gd"; lspBufAction = "definition"; options.desc = "Go to definition"; } # or <C-]> look `:h lsp-defaults`
        { key = "gD"; lspBufAction = "declaration"; options.desc = "Go to declaration"; }
        { key = "<leader>l"; action = "<CMD>lsp restart<Enter>"; options.desc = "Restart LSP"; }
        { key = "<leader>ui";
          action = lib.nixvim.mkRaw ''
            function()
              local inlay_hint_state = vim.lsp.inlay_hint.is_enabled()
              vim.notify("Inlay hints are now " .. (inlay_hint_state and "disabled" or "enabled"))
              vim.lsp.inlay_hint.enable(not inlay_hint_state, {bufnr = bufnr})
            end
          '';
          options.desc = "Toggle inlay hints";
        }
        /*nixfmt:enable*/
      ];
    };
  };
}
