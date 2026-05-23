{
  config.plugins.conform-nvim = {
    enable = true;
    settings = {
      formatters_by_ft = {
        c = [ "clang_format" ];
        nix = [ "nixfmt" ];
        python = [ "ruff_format" ];
      };
      # Either add formatters here or individually in each project using devShells
      # formatters = {
      #   ruff_format.command = lib.getExe pkgs.ruff;
      # };
      format_on_save = {
        timeout_ms = 500;
        lsp_format = "fallback";
      };
    };
  };
}
