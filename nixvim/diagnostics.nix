{ lib, ... }: {
  config = {
    diagnostic.settings = {
      signs.text =
        let
          severity = "vim.diagnostic.severity";
        in
        lib.nixvim.toRawKeys {
          "${severity}.ERROR" = " ";
          "${severity}.WARN" = " ";
          "${severity}.HINT" = " ";
          "${severity}.INFO" = " ";
        };

      float.source = "always";
      jump.on_jump = lib.nixvim.mkRaw ''
        (function(diagnostic, bufnr)
          if not diagnostic then return end
          vim.diagnostic.open_float()
        end)
      '';

      virtual_text = {
        current_line = false;
        spacing = 2;
        source = "if_many";
        prefix = "●";
      };

      severity_sort = true;
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>ud";
        action = lib.nixvim.mkRaw ''
          function()
            local current = vim.diagnostic.config().virtual_text
            local enabled = type(current) == "table" and current.current_line

            vim.notify(
              "Virtual text is now " ..
              (enabled and "enabled for the current line" or "enabled for the entire buffer")
            )

            vim.diagnostic.config({
              virtual_text = {
                current_line = not enabled,
                spacing = 2,
                source = "if_many",
                prefix = "●"
              },
            })
          end
        '';
        options.desc = "Toggle virtual text for current line or entire buffer";
      }
    ];
  };
}
