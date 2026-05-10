{
  config = {
    plugins = {
      gitsigns.enable = true; # Toggle cuurent line blame? and more config
      lazygit.enable = true;
      # diffview.enable = true;
      # neogit
    };

    keymaps = [
      {
        mode = "n";
        action = "<cmd>Gitsigns next_hunk<CR>";
        key = "]h";
        options.desc = "Next Hunk";
      }
      {
        mode = "n";
        action = "<cmd>Gitsigns prev_hunk<CR>";
        key = "[h";
        options.desc = "Prev Hunk";
      }
      # TODO: stage, reset, preview hunks (stage reset selected range)
      {
        mode = "n";
        key = "<leader>g";
        action = "<CMD>LazyGit<CR>";
        options.desc = "Open LazyGit";
      }
    ];
  };
}
