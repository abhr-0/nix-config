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
        # current_line = true;
        spacing = 2;
        source = "if_many";
        prefix = "●";
      };

      severity_sort = true;
    };
  };
}
