{
  plugins = {
    nvim-autopairs.enable = true;

    friendly-snippets.enable = true;
    # luasnip = {
    #   enable = true;
    #   # Add friendly-snippets
    #   fromVscode = [ { } ];
    # };

    blink-cmp = {
      enable = true;
      settings = {
        appearance.nerd_font_variant = "normal";
        completion.documentation.auto_show = true;
        signature.enabled = true;
        sources.default = [
          "lsp"
          "path"
          "snippets"
          "buffer"
        ];
      };
    };
  };
}
