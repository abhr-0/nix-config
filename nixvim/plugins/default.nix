{
  config = {
    plugins = {
      web-devicons.enable = true; # Icons

      lualine.enable = true;

      treesitter = {
        enable = true;
        highlight.enable = true;
        indent.enable = true;
        folding.enable = true;
      };
      nvim-surround.enable = true;

      which-key = {
        enable = true;
        settings.preset = "helix";
      };

      render-markdown.enable = true;
      rainbow-delimiters.enable = true;
    };
  };
}
