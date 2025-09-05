{ pkgs, ... }:
{

  home.packages = with pkgs; [
    unstable.jetbrains.idea-community
  ];

  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    git = {
      enable = true;
      userName = "abhr-0";
      userEmail = "121384410+abhr-0@users.noreply.github.com";
    };

    neovim =
      let
        vscode-multi-cursor = pkgs.vimUtils.buildVimPlugin {
          name = "vscode-multi-cursor";
          src = pkgs.fetchFromGitHub {
            owner = "vscode-neovim";
            repo = "vscode-multi-cursor.nvim";
            rev = "210d64a6d190383a81b8dcdf8779d357006f3a69";
            sha256 = "sha256-0o0aiWY7AdtSo4nCfq3fGj0PEfngLgOnK/Y6NTWPWzU=";
          };
        };
      in
      {
        enable = true;
        plugins = with pkgs.vimPlugins; [
          {
            plugin = vscode-multi-cursor;
            config = "lua require('vscode-multi-cursor').setup()";
          }
          {
            plugin = nvim-surround;
            config = "lua require('nvim-surround').setup()";
          }
        ];
        extraLuaConfig = ''

          -- Set relative line numbering
          vim.o.relativenumber = true

          -- Sync clipboard between OS and Neovim.
          vim.schedule(function()
            vim.o.clipboard = 'unnamedplus'
          end)

          -- Enable break indent
          vim.o.breakindent = true

          -- Minimal number of screen lines to keep above and below the cursor.
          vim.o.scrolloff = 8

          -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
          vim.o.ignorecase = true
          vim.o.smartcase = true

          -- Preview substitutions live, as you type!
          vim.o.inccommand = 'split'

          -- Clear highlights on search when pressing <Esc> in normal mode
          vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

          -- Highlight when yanking (copying) text
          vim.api.nvim_create_autocmd('TextYankPost', {
            desc = 'Highlight when yanking (copying) text',
            group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
            callback = function()
              vim.hl.on_yank()
            end,
          })
        '';
        extraPackages = [ pkgs.wl-clipboard ]; # For clipboard syncing with OS
      };

    vscode = {
      enable = true;
      package = pkgs.unstable.vscodium;
    };
  };

  # Note: GNOME's seahorse replaces the functionality of ssh, ssh-agent, gpg and gpg-agent
  #
  # programs.gpg.enable = true;
  # services.gpg-agent = {
  #   enable = true;
  #   pinentryPackage = pkgs.pinentry-gnome3;
  # };

  home.sessionVariables = {
    DOCKER_HOST = "unix:///run/user/1000/podman/podman.sock";
    EDITOR = "codium --wait";
  };
}
