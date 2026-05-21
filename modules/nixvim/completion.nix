{
  config,
  lib,
  pkgs,
  ...
}:
{
  extraPlugins = lib.mkIf config.plugins.copilot-chat.enable [
    pkgs.vimPlugins.blink-cmp-copilot-chat
  ];

  plugins = {
    nvim-autopairs.enable = true;

    friendly-snippets.enable = true;
    # luasnip = {
    #   enable = true;
    #   # Add friendly-snippets
    #   fromVscode = [ { } ];
    # };

    blink-cmp = {
      enable = true;
      settings = lib.mkMerge [
        {
          appearance.nerd_font_variant = "normal";
          completion.documentation.auto_show = true;
          signature.enabled = true;
          sources.default = [
            "lsp"
            "path"
            "snippets"
            "buffer"
          ];
        }
        (lib.mkIf config.plugins.copilot-chat.enable {
          sources.per_filetype.copilot-chat = [ "copilot_c" ];
          sources.providers = {
            copilot_c = {
              name = "Copilot Chat";
              module = "blink-cmp-copilot-chat";
            };
          };
        })
      ];
    };
  };
}
