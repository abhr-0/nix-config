{ config, lib, ... }:
{
  plugins = {
    todo-comments.enable = true;
    snacks = {
      enable = true;
      settings = {
        bigfile.enabled = true;
        indent.enabled = true;
        notifier.enabled = true;
        picker.ui_select = true;
        quickfile.enabled = true;
        scroll.enabled = true;
        statuscolumn.enabled = true;
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
      key = "<leader>f";
      options.desc = "Find Files (Smart)";
    }
    {
      mode = "n";
      action = lib.nixvim.mkRaw "function() Snacks.picker.buffers() end";
      key = "<leader>b";
      options.desc = "Find Buffers";
    }
    {
      mode = "n";
      action = lib.nixvim.mkRaw "function() Snacks.picker.grep() end";
      key = "<leader>/";
      options.desc = "Grep";
    }
    {
      mode = "n";
      action = lib.nixvim.mkRaw "function() Snacks.picker.help() end";
      key = "<leader>?";
      options.desc = "Find Help";
    }
    {
      mode = "n";
      action = lib.nixvim.mkRaw "function() Snacks.picker.keymaps() end";
      key = "<leader>sk";
      options.desc = "Find Keymaps";
    }
    {
      mode = "n";
      action = lib.nixvim.mkRaw "function() Snacks.picker.diagnostics() end";
      key = "<leader>d";
      options.desc = "Find Diagnostics";
    }
    {
      mode = "n";
      action = lib.nixvim.mkRaw "function() Snacks.picker.lsp_config() end";
      key = "<leader>sl";
      options.desc = "Find LSP Servers";
    }
    (lib.mkIf config.plugins.todo-comments.enable {
      mode = "n";
      action = lib.nixvim.mkRaw "function() Snacks.picker.todo_comments() end";
      key = "<leader>st";
      options.desc = "Find TODOs";
    })
    {
      mode = [
        "n"
        "t"
      ];
      action = lib.nixvim.mkRaw "function() Snacks.terminal.toggle() end";
      key = "<C-\\>";
      options.desc = "Toggle terminal";
    }
    {
      mode = [
        "n"
        "t"
      ];
      action = lib.nixvim.mkRaw "function() Snacks.terminal.toggle() end";
      key = "<C-_>";
      options.desc = "which_key_ignore";
    }
    {
      mode = "n";
      action = lib.nixvim.mkRaw "function() Snacks.notifier.show_history() end";
      key = "<leader>n";
      options.desc = "Show Notification History";
    }
    {
      mode = "n";
      action = lib.nixvim.mkRaw "function() Snacks.notifier.undo() end";
      key = "<leader>u";
      options.desc = "Show Undo History";
    }
  ];
}
