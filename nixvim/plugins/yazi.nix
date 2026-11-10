{
  plugins.yazi.enable = true;

  keymaps = [
    {
      mode = "n";
      action = "<CMD>Yazi<CR>";
      key = "<leader>y";
      options.desc = "Toggle Yazi File Manager";
    }
  ];
}
