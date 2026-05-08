{ config, lib, ... }:
{
  plugins = {
    todo-comments.enable = true;
    snacks = {
      enable = true;
      settings = {
        # bigfile.enabled = true; TODO: enable?
        dashboard = {
          enabled = true;
          # keys # TODO: re-assign
          sections = [
            { section = "header"; }
            {
              icon = " ";
              title = "Keymap";
              section = "keys";
              indent = 2;
              padding = 1;
            }
            {
              icon = " ";
              title = "Recent Files";
              section = "recent_files";
              indent = 2;
              padding = 2;
            }
            {
              icon = " ";
              title = "Projects";
              section = "projects";
              indent = 2;
              padding = 2;
            }
          ];
        };
        indent.enabled = true; # TODO: Multi-color?
        notifier.enabled = true;
        quickfile.enabled = false;
        scroll.enabled = true;
        statuscolumn.enabled = true;
        # words.enabled = true;
      };
      luaConfig.post = ''
        vim.api.nvim_create_autocmd("LspProgress", {
          ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
          callback = function(ev)
            local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
            vim.notify(vim.lsp.status(), "info", {
              id = "lsp_progress",
              title = "LSP Progress",
              opts = function(notif)
                notif.icon = ev.data.params.value.kind == "end" and " "
                  or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
              end,
            })
          end,
        })
      '';
    };
  };

  # Shows progress when LSP is loading, another version available on snacks.notifier docs
  # autoCmd = [
  #   {
  #     event = "LspProgress";
  #     callback = lib.nixvim.mkRaw ''
  #       ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
  #       function(ev)
  #         local spinner =  { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
  #           vim.notify(vim.lsp.status(), "info", {
  #             id = "lsp_progress",
  #             title = "LSP Progress",
  #             opts = function(notif)
  #               notif.icon = ev.data.params.value.kind == "end" and " "
  #               or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
  #             end,
  #           })
  #       end,
  #     '';
  #     desc = "Show progress when LSP is loading";
  #   }
  # ];

  keymaps = [
    {
      mode = "n";
      action = lib.nixvim.mkRaw "function() Snacks.explorer() end";
      key = "<leader>e";
      options.desc = "Open File Explorer";
    }
    {
      mode = "n";
      action = lib.nixvim.mkRaw "function() Snacks.picker.smart() end";
      key = "<leader>ff";
      options.desc = "Find Files (Smart)";
    }
    {
      mode = "n";
      action = lib.nixvim.mkRaw "function() Snacks.picker.buffers() end";
      key = "<leader>fb";
      options.desc = "Find Buffers";
    }
    {
      mode = "n";
      action = lib.nixvim.mkRaw "function() Snacks.picker.grep() end";
      key = "<leader>fg";
      options.desc = "Grep";
    }
    {
      mode = "n";
      action = lib.nixvim.mkRaw "function() Snacks.picker.help() end";
      key = "<leader>fh";
      options.desc = "Find Help";
    }
    {
      mode = "n";
      action = lib.nixvim.mkRaw "function() Snacks.picker.keymaps() end";
      key = "<leader>fk";
      options.desc = "Find Keymaps";
    }
    {
      mode = "n";
      action = lib.nixvim.mkRaw "function() Snacks.picker.diagnostics() end";
      key = "<leader>fd";
      options.desc = "Find Diagnostics";
    }
    {
      mode = "n";
      action = lib.nixvim.mkRaw "function() Snacks.picker.lsp_config() end";
      key = "<leader>fl";
      options.desc = "Find LSP Servers";
    }
    {
      mode = "n";
      action = lib.nixvim.mkRaw "function() Snacks.picker.projects() end";
      key = "<leader>fp";
      options.desc = "Find Projects";
    }
    (lib.mkIf config.plugins.todo-comments.enable {
      mode = "n";
      action = lib.nixvim.mkRaw "function() Snacks.picker.todo_comments() end";
      key = "<leader>ft";
      options.desc = "Find TODOs";
    })
    {
      mode = [
        "n"
        "t"
      ];
      action = lib.nixvim.mkRaw "function() Snacks.terminal.toggle() end";
      key = "<leader>t";
      options.desc = "Toggle terminal";
    }
    {
      mode = "n";
      action = lib.nixvim.mkRaw "function() Snacks.notifier.show_history() end";
      key = "<leader>n";
      options.desc = "Show Notification History";
    }
    # git diff/status, stash
    # grep onwards
    # undo
  ];
}
