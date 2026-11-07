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
        { key = "<leader>l"; action = "<CMD>lsp restart<Enter>"; options.desc = "Restart LSP"; }
        /*nixfmt:enable*/
      ];
    };
  };
}
