{ lib, pkgs, ... }: {
  lsp.servers = {
    basedpyright.enable = true;
    ruff.enable = true;
  };

  plugins.conform-nvim.settings = {
    formatters_by_ft.python = [ "ruff_format" ];
    formatters.ruff_format.command = lib.getExe pkgs.ruff;
  };

  files."after/ftplugin/python.lua" = {
    localOpts.colorcolumn = [ "88" ];
  };
}
