This document holds various things:

# Language specific configuration
Only `lsp.nix` and `format.nix` contain language specific configs

# Useful commands/keymaps:
- increment: `<C-a>`
- decrement: `<C-x>`
- toggle case for single character: `~`
- toggle case: `gu` for lower, `gU` for upper
- `J` to join bottom line and append
- surround keybinds? `ysiw<char>` to add `<char>`
- `Q` repeats last macro
- `q:` command line history window also `q/` and `q?` for search history
- `ZZ` and `ZQ`
- `]b`, `[b` to switch buffers and to delete?
- double backtick toggles last jump

## In Visual Mode
- expand selection: `an`
- shrink selection: `in`
- select next node: `]n`
- select previous node : `[n`

# Reference configs
[Gaetan Lepage](https://github.com/GaetanLepage/nix-config/tree/master/modules/home/dev/_dev/programs/neovim)
[dc-tec](https://github.com/dc-tec/nixvim)
[Mikael Fangel](https://github.com/MikaelFangel/nixvim-config)
[XhuyZ](https://github.com/XhuyZ/nixvim)
[ribru17](https://github.com/ribru17/.dotfiles/blob/master/.config/nvim) for bindings, ezsemicolon, hover

# More plugins
- overseer / any code runner
- lspsaga
- molten
- grug-far
- noice
- fidget
- luasnip
- diffview
- telescope
- nvim-lint
- dap (dap-ui and dap-virtual-text)
- trouble
- colorizer
- treesitter-textobjects
- nvim-ts-autotag
- nvim-ts-context-commentstring
- hmts # for better nix code injection?
- mini.ai
- markdown-previewer
- vimtex and texlab for latex
- treesitter-context
- treesitter-textobjects 

# Future:
## Consider lazy-loading:
- lazygit
- dap
- ai
- markdown-previewer and render-markdown
- snippets
- db tooling?
- lang specific plugins
## Other
- file renaming with LSP support? (like oil and yazi)
- snack.words
- blink.cmp: completion.menu.draw.columns [Link](https://main.cmp.saghen.dev/configuration/completion#menu)
- Use virtual_lines for diagnostics for certain filetypes
