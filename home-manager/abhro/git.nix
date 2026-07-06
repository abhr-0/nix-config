{ pkgs, ... }:
{
  programs = {
    lazygit.enable = true;

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

        # Prompt commands on typo
        help.autocorrect = "prompt";

        # Diff
        diff = {
          algorithm = "histogram";
          indentHeuristic = true;
        };
        core.pager = "${pkgs.delta}/bin/delta";
        delta = {
          line-number = true;
          side-by-side = true;
          navigate = true;
        };
        interactive = {
          diffFilter = "${pkgs.delta}/bin/delta --color-only";
          singlekey = true;
        };

        # Log
        log.graph = true;

        # Status
        status = {
          branch = true;
          showStash = true;
          showUntrackedFiles = "all";
        };
      };
    };
  };
}
