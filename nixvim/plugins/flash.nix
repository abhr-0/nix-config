{ lib, ... }:
{
  config = {
    plugins.flash.enable = true;

    keymaps = [
      {
        mode = [
          "n"
          "x"
          "o"
        ];
        key = "s";
        action = lib.nixvim.mkRaw "function() require(\"flash\").jump() end";
        options.desc = "Flash";
      }
      {
        mode = [
          "n"
          "x"
          "o"
        ];
        key = "S";
        action = lib.nixvim.mkRaw "function() require(\"flash\").treesitter() end";
        options.desc = "Flash Treesitter";
      }
      # TODO: more
    ];
  };
}
