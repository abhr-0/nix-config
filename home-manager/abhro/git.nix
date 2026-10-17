{ pkgs, config, ... }:
{
  programs = {
    lazygit = {
      enable = true;

      settings = {
        git.diffRenderers = [
          { command = "delta --{{colorScheme}} --paging=never"; }
          {
            type = "extDiff";
            command = "difft --color=always --background={{colorScheme}} --context={{diffContext}}";
          }
        ];
      };
    };

    delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        line-number = true;
        side-by-side = true; # Can get annoying
        syntax-theme = config.programs.bat.config.theme;
      };
    };

    bat = {
      enable = true;
      themes.kanagawa = {
        src = pkgs.vimPlugins.kanagawa-nvim;
        file = "extras/tmTheme/kanagawa.tmTheme";
      };
      config.theme = "kanagawa";
    };

    difftastic = {
      enable = true;
      # git = {
      #   enable = true;
      #   mode = "difftool"; # As I want delta to be used by default # TODO: Uncomment in next release
      # };
    };

    git = {
      enable = true;
      lfs.enable = true;
      signing = {
        key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB1Wf+uEOWkpzbspHnKyoGRbtlTQR++A8o4iM2IiWnv/ 121384410+abhr-0@users.noreply.github.com";
        format = "ssh";
        signByDefault = true;
      };
      settings = {
        # Commit Author
        user = {
          name = "Abhraneel Mukherjee";
          email = "121384410+abhr-0@users.noreply.github.com";
        };

        init.defaultBranch = "main";

        # Push & Pull
        push.autoSetupRemote = true;
        fetch.prune = true;
        pull.rebase = true;
        rebase.autoStash = true;

        # URL shorthands
        url = {
          "git@github.com/abhr-0/".insteadOf = "a0:";
          "git@github.com:".insteadOf = "github:"; # Mimic nix3 commands
        };

        help.autocorrect = "prompt";
        diff.algorithm = "histogram";
        status.short = true;
      };
    };
  };
}
