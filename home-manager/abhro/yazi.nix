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

    settings.mgr.ratio = [
      1
      2
      2
    ]; # Or, use 2, 3, 3

    keymap = {
      mgr.prepend_keymap = [
        {
          on = [
            "g"
            "p"
          ];
          run = "cd ~/Projects";
        }
        {
          on = [
            "g"
            "D"
          ];
          run = "cd ~/Documents";
        }
        {
          on = [
            "g"
            "P"
          ];
          run = "cd ~/Pictures";
        }
        {
          on = [
            "g"
            "M"
          ];
          run = "cd ~/Music";
        }
        {
          on = [
            "g"
            "V"
          ];
          run = "cd ~/Videos";
        }
      ];
    };
  };
}
