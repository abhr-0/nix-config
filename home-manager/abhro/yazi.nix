{ pkgs, ... }: {
  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
    # flavors.kanagawa = pkgs.localPkgs.yazi-flavor-kanagawa;
    # theme.flavor.dark = "kanagawa";
    plugins = {
      full-border = {
        package = pkgs.yaziPlugins.full-border;
        setup = true;
      };

      # clipboard = pkgs.yaziPlugins.clipboard; # Builtin-in support soon: https://github.com/XYenon/clipboard.yazi/issues/11, https://github.com/sxyazi/yazi/discussions/4280
    };

    /*nixfmt:disable*/
    settings.mgr.ratio = [ 1 2 2 ]; # Or, use 2, 3, 3

    keymap = {
      mgr.prepend_keymap = [
        # Remember to use `t` for tabs and `g` for bookmarks
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
