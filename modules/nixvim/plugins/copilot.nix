{
  config = {
    plugins = {
      copilot-lua = {
        enable = true;
        settings = {
          panel.enabled = false;
          suggestion = {
            enabled = true;
            auto_trigger = true;
          };
        };
      };
      copilot-chat = {
        enable = true;
        settings = {
          auto_insert_mode = true;
          headers = {
            assistant = " Copilot";
            tool = " Tool";
            user = " User";
          };
          window.width = 0.3;
        };
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>c";
        action = ":CopilotChatToggle<CR>";
        options.desc = "Toggle Copilot Chat";
      }
    ];
  };
}
