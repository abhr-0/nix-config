{ pkgs, ... }: {
  programs.yazi = {
    enable = true;
    shellWrapperName = "y";

    plugins.full-border = {
      package = pkgs.yaziPlugins.full-border;
      setup = true;
    };

    /*nixfmt:disable*/
    settings.mgr.ratio = [ 1 2 2 ]; # Or, use 2, 3, 3

    theme.mode = {
      normal_main = { fg = "white"; bg = "cyan"; };
      normal_alt = { fg = "cyan"; bg = "white"; };
    };

    keymap = {
      mgr.prepend_keymap = [
        { on = [ "g" "p" ]; run = "cd ~/Projects"; desc = "Go to ~/Projects"; }
        { on = [ "g" "D" ]; run = "cd ~/Documents"; desc = "Go to ~/Documents";}
        { on = [ "g" "P" ]; run = "cd ~/Pictures"; desc = "Go to ~/Pictures/";}
        { on = [ "g" "M" ]; run = "cd ~/Music"; desc = "Go to ~/Music"; }
        { on = [ "g" "V" ]; run = "cd ~/Videos"; desc = "Go to ~/Videos"; }
      ];
    };
    /*nixfmt:enable*/
  };
}
