{
  config = {
    plugins = {
      web-devicons.enable = true; # Icons

      nvim-autopairs.enable = true;
      lualine.enable = true;

      gitsigns.enable = true; # Toggle cuurent line blame? and more config

      lazygit.enable = true;

      treesitter = {
        enable = true;
        highlight.enable = true;
        indent.enable = true;
        folding.enable = true;
      };
      # treesitter-textobjects
      # mini.ai
      # surround = true;
      # hmts.enable = true; # for better nix code injection

      which-key = {
        enable = true;
        settings.preset = "helix";
      };

      render-markdown.enable = true;
      rainbow-delimiters.enable = true;
      # telescope.enable = true;
      # luasnip
      # conform for non-lsp formatting and linking eg. statix
      # dap for debugging
      # leap / flash
      # trouble for diagnostics
    };
  };
}
