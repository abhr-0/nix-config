{
  lsp.servers = {
    ty.enable = true;
    ruff.enable = true;
  };

  # NOTE: `formatters.ruff_format.command` omitted; `lsp.servers.ruff` already provides pkgs.ruff
  plugins.conform-nvim.settings.formatters_by_ft.python = [ "ruff_format" ];

  files."after/ftplugin/python.lua" = {
    localOpts.colorcolumn = [ "88" ];
  };
}
