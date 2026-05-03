{ config, pkgs, ... }:
{
  programs.git = {
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
        name = "abhr-0";
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

  home.shellAliases =
    let
      mkGitAlias = cmd: "${config.programs.git.package}/bin/git " + cmd;
    in
    {
      gs = mkGitAlias "status --short";
      gl = mkGitAlias "log";
      glo = mkGitAlias "log --oneline";

      ga = mkGitAlias "add";
      gap = mkGitAlias "add --patch";
      gc = mkGitAlias "commit"; # staged only
      gca = mkGitAlias "commit --amend"; # same as above

      gp = mkGitAlias "push";
      gf = mkGitAlias "fetch";
      gu = mkGitAlias "pull";

      gb = mkGitAlias "branch";
      gco = mkGitAlias "checkout";

      gi = mkGitAlias "init";
      gcl = mkGitAlias "clone";

      gsh = mkGitAlias "stash"; # sub-commands

      gd = mkGitAlias "diff";
      gds = mkGitAlias "diff --staged";
    };
}
