{ lib, config, ... }:
{
  config = {
    plugins.persistence.enable = true;

    autoCmd = [
      {
        event = "VimEnter";
        callback = lib.nixvim.mkRaw ''
          function()
            if vim.fn.argc() == 0 then
              require('persistence').load()
            end
          end
        '';
        nested = true;
      }
    ];

    keymaps = [
      (lib.mkIf config.plugins.snacks.enable {
        mode = "n";
        action = lib.nixvim.mkRaw ''
          function()
            Snacks.picker.projects({
              confirm = function(picker, item)
                picker:close()
                if not item or not item.file then
                  return
                end

                -- save current buffers if modified
                local modified_buffers_present = vim.iter(vim.api.nvim_list_bufs()):any(function(buf)
                  return vim.bo[buf].modified
                end)
                if modified_buffers_present then
                  vim.cmd("confirm wall")
                end

                -- save current session before switching
                require('persistence').save()

                -- change to the selected project's directory
                local project_name = vim.fs.basename(item.file)
                vim.fn.chdir(item.file)
                -- close all buffers to avoid confusion with files from the previous project
                vim.cmd("%bd!")

                vim.schedule(function()
                  vim.notify("Switched to project: " .. project_name, "info", { title = "Project Switch" })
                  require('persistence').load()
                end)
              end,
            })
          end
        '';
        key = "<leader>sp";
        options.desc = "Find Projects";
      })
    ];

    opts.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,winpos,terminal";
  };
}
