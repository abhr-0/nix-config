{ lib, ... }:
{
  plugins = {
    web-devicons.enable = true; # Icons

    lualine.enable = true;

    treesitter = {
      enable = true;
      highlight.enable = true;
      indent.enable = true;
      folding.enable = true;
    };
    nvim-surround.enable = true;

    which-key = {
      enable = true;
      settings = {
        preset = "helix";
        spec =
          let
            group = name: prefix: lib.nixvim.listToUnkeyedAttrs [ prefix ] // { group = name; };
          in
          [
            (group "Leader" "<leader>")
            (group "Search" "<leader>s")
            (group "Git Hunk" "<leader>h")
            (group "UI Toggles" "<leader>u")
          ];
      };
    };

    render-markdown.enable = true;
    # rainbow-delimiters.enable = true; # TODO: Keep this?
  };
}
