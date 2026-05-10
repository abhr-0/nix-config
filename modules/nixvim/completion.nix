{
  plugins = {
    friendly-snippets.enable = true;
    luasnip = {
      enable = true;
      fromVscode = [
        { }
      ];
    };

    blink-cmp = {
      enable = true;
      settings = {
        appearance.nerd_font_variant = "normal";
        completion.documentation.auto_show = true;
        keymap.preset = "super-tab";
        signature.enabled = true;
      };
    };
  };
}
