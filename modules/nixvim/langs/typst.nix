{ lib, pkgs, ... }: {
  plugins = {
    typst-preview.enable = true;

    conform-nvim.settings = {
      formatters_by_ft.typst = [ "typstyle" ];
      formatters.typstyle.command = lib.getExe pkgs.typstyle;
    };
  };

  lsp.servers.tinymist.enable = true;

  files."after/ftplugin/typst.lua" = {
    # NOTE: no vim.notify() set here
    keymaps = [
      {
        mode = "n";
        key = "<leader>up";
        action = "<CMD>TypstPreviewToggle<CR>";
        options = {
          buffer = true;
          desc = "Toggle Preview Typst file in browser";
        };
      }
      {
        mode = "n";
        key = "<leader>uf";
        action = "<CMD>TypstPreviewFollowCursorToggle<CR>";
        options = {
          buffer = true;
          desc = "Toggle following cursor for Typst preview";
        };
      }
    ];
  };
}
