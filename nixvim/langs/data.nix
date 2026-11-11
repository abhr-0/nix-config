# Formatters for data/config/document filetypes: JSON(C), YAML, TOML, Markdown.
{ lib, pkgs, ... }: {
  lsp.servers = {
    markdown_oxide.enable = true;
    taplo.enable = true;
  };

  # NOTE: `formatters.taplo.command` omitted; `lsp.servers.taplo` already provides pkgs.taplo
  plugins.conform-nvim.settings = {
    formatters_by_ft = {
      json = [ "prettierd" ];
      jsonc = [ "prettierd" ];
      yaml = [ "prettierd" ];
      markdown = [ "prettierd" ];
      toml = [ "taplo" ];
    };

    formatters.prettierd = {
      command = lib.getExe pkgs.prettierd;
      # Match the 100-column default set in nixvim/default.nix
      append_args = [
        "--print-width"
        "100"
      ];
    };
  };
}
