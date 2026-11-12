{ pkgs, config, ... }:
{
  programs = {
    gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
        telemetry = "disabled";
        aliases = {
          co = "pr checkout";
          pv = "pr view";
          pc = "pr create";
          pl = "pr list";
          iv = "issue view";
          il = "issue list";
        };
      };
    };

    gh-dash.enable = true; # NOTE: Empty settings, results in default config

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
        customCommands = [
          {
            key = "P";
            command = "git push {{.SelectedRemote.Name}} {{.SelectedCommit.Sha}}:{{.SelectedLocalBranch.Name}}";
            description = "Push a specific commit (and any preceding)";
            context = "commits";
            loadingText = "Pushing commit...";
            output = "log";
          }
          # https://github.com/jesseduffield/lazygit/wiki/Custom-Commands-Compendium#list-and-select-github-pr-for-checkout
          # https://github.com/jesseduffield/lazygit/wiki/Custom-Commands-Compendium#opening-git-mergetool
        ];
      };
    };

    delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        line-numbers = true;
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
      # NOTE: gpg.ssh.allowedSignersFile is intentionally NOT set.
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
