{ lib, ... }:
{
  config = {
    plugins.flash.enable = true;

    keymaps = with lib.nixvim; [
      /*nixfmt:disable*/
      { mode = [ "n" "x" "o" ];
        key = "s";
        action = mkRaw "function() require(\"flash\").jump() end";
        options.desc = "Flash";
      }
      { mode = [ "n" "x" "o" ];
        key = "S";
        action = mkRaw "function() require(\"flash\").treesitter() end";
        options.desc = "Flash Treesitter";
      }
      # TODO: more
      /*nixfmt:enable*/
    ];
  };
}
