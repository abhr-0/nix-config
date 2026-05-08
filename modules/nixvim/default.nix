{ lib, ... }:
{
  config = {
    colorschemes.onedark.enable = true;
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

      splitright = true;
      splitbelow = true;

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
        action = "<CMD>nohlsearch<CR>";
        key = "<Esc>";
        options.desc = "Clear search highlights";
      }
    ];
  };
}
