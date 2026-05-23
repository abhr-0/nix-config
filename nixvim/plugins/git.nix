{ lib, ... }:
{
  config = {
    plugins = {
      gitsigns.enable = true;
      lazygit.enable = true;
    };

    keymaps =
      let
        gitsigns = "require('gitsigns')";
      in
      [
        {
          mode = "n";
          action = lib.nixvim.mkRaw ''
            function()
              if vim.wo.diff then
                vim.cmd.normal({']c'})
              else
                ${gitsigns}.nav_hunk('next')
              end
            end
          '';
          key = "]h";
          options.desc = "Next Hunk";
        }
        {
          mode = "n";
          action = lib.nixvim.mkRaw ''
            function()
              if vim.wo.diff then
                vim.cmd.normal({'[c'})
              else
                ${gitsigns}.nav_hunk('prev')
              end
            end
          '';
          key = "[h";
          options.desc = "Prev Hunk";
        }
        {
          mode = "n";
          action = lib.nixvim.mkRaw "${gitsigns}.stage_hunk";
          key = "<leader>hs";
          options.desc = "Stage Hunk";
        }
        {
          mode = "n";
          action = lib.nixvim.mkRaw "${gitsigns}.reset_hunk";
          key = "<leader>hr";
          options.desc = "Reset Hunk";
        }
        {
          mode = "v";
          action = lib.nixvim.mkRaw "function() ${gitsigns}.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end";
          key = "<leader>hs";
          options.desc = "Stage Hunk Selected";
        }
        {
          mode = "v";
          action = lib.nixvim.mkRaw "function() ${gitsigns}.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end";
          key = "<leader>hr";
          options.desc = "Reset Hunk Selected";
        }
        {
          mode = "n";
          action = lib.nixvim.mkRaw "${gitsigns}.preview_hunk";
          key = "<leader>hp";
          options.desc = "Preview Hunk"; # Use inline?
        }
        {
          mode = "n";
          action = lib.nixvim.mkRaw "function() ${gitsigns}.blame_line({ full = true }) end"; # Full needed?
          key = "<leader>hb";
          options.desc = "Blame Line";
        }
        {
          mode = "n";
          action = lib.nixvim.mkRaw ''
            function()
              if vim.wo.diff then
                vim.cmd("only")
                vim.cmd("diffoff")
              else
                if vim.tbl_isempty(${gitsigns}.get_hunks()) then
                  vim.notify("No Git changes in current buffer", vim.log.levels.INFO)
                else
                  ${gitsigns}.diffthis()
                end
              end
            end
          '';
          key = "<leader>hd";
          options.desc = "Diff Current Buffer";
        }
        {
          mode = "n";
          key = "<leader>g";
          action = "<CMD>LazyGit<CR>";
          options.desc = "Open LazyGit";
        }
      ];
  };
}
