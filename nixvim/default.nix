{ self, lib, ... }:
{
  config = {
    # As nixvim manages it's own nixpkgs
    nixpkgs.overlays = [ self.overlays.default ];
    colorschemes = {
      bamboo.enable = true;
      onedark.enable = true; # Different tones available
      gruvbox.enable = true;
      monokai-pro.enable = true;
    };
    colorscheme = "bamboo";

    clipboard = {
      register = "unnamedplus";
      providers.wl-copy.enable = true;
    };
    viAlias = true;
    vimAlias = true;

    opts = {
      number = true;
      relativenumber = true;
      colorcolumn = [ 80 ]; # Change?
      cursorline = true;

      tabstop = 2;
      softtabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      smartindent = true;
      breakindent = true; # ?

      showmode = false;

      splitright = true;
      splitbelow = true;

      winborder = "rounded";

      scrolloff = 4;
      sidescrolloff = 4;

      ignorecase = true;
      smartcase = true;
      inccommand = "split"; # ?

      fillchars.eob = " "; # Hide "~" on empty lines

      undofile = true;

      updatetime = 250;
      timeoutlen = 500;

      mouse = "a";

      foldlevelstart = 99;
    };

    globals.mapleader = " ";

    autoCmd = [
      {
        event = "TextYankPost";
        callback = lib.nixvim.mkRaw "function() vim.hl.on_yank() end";
        group = "kickstart-highlight-yank";
        desc = "Highlight when yanking text";
      }
    ];
    autoGroups."kickstart-highlight-yank".clear = true;

    keymaps = [
      {
        mode = "n";
        # The <Esc> is added for flash.nvim not being able to clear highlights
        # when using `f`, `F`, `t` and `T` motions
        action = "<CMD>nohlsearch<CR><Esc>";
        key = "<Esc>";
        options.desc = "Clear search highlights";
      }
      {
        mode = "i";
        action = "<Esc>";
        key = "jk";
        options.desc = "Clear search highlights";
      }
      {
        mode = "n";
        action = "<C-w>h";
        key = "<C-h>";
        options.desc = "Switch to left split";
      }
      {
        mode = "n";
        action = "<C-w>j";
        key = "<C-j>";
        options.desc = "Switch to bottom split";
      }
      {
        mode = "n";
        action = "<C-w>k";
        key = "<C-k>";
        options.desc = "Switch to top split";
      }
      {
        mode = "n";
        action = "<C-w>l";
        key = "<C-l>";
        options.desc = "Switch to right split";
      }

      # Better indenting in visual mode
      {
        mode = "v";
        action = "<gv";
        key = "<";
        options.desc = "Left Indent";
      }
      {
        mode = "v";
        action = ">gv";
        key = ">";
        options.desc = "Right Indent";
      }
    ];
  };
}
