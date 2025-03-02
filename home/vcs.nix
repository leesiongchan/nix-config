{ pkgs, ... }:

{
  # @ref https://github.com/nix-community/home-manager/blob/master/modules/programs/git.nix
  programs.git = {
    enable = true;

    userName = "Harvey";
    userEmail = "324418+leesiongchan@users.noreply.github.com";

    # some come from https://jvns.ca/blog/2024/02/16/popular-git-config-options/
    extraConfig = {
      core = {
        autocrlf = "input";
        eol = "lf";
      };

      diff = {
        algorithm = "histogram";
      };

      feature.manyFiles = true;

      fetch = {
        prune = true;
      };

      gpg = {
        format = "ssh";
      };

      help = {
        autocorrect = 3; # tenths of second before running
      };

      # @see https://github.com/tummychow/git-absorb/issues/81
      index.skipHash = false;
      init.defaultBranch = "main";

      merge = {
        # https://ductile.systems/zdiff3/
        conflictStyle = "zdiff3";
      };

      pull = {
        rebase = true;
      };

      push = {
        autoSetupRemote = true;
        followTags = true;
      };

      rebase = {
        autoStash = true;
        autoSquash = true;
        updateRefs = true;
      };

      rerere = {
        enabled = true;
        autoUpdate = true;
      };

      status = {
        showUntrackedFiles = "all";
      };

      url = {
        "https://github.com/".insteadOf = "gh:";
        "ssh://git@github.com".pushInsteadOf = "gh:";
        "https://gitlab.com/".insteadOf = "gl:";
        "ssh://git@gitlab.com".pushInsteadOf = "gl:";
      };
    };

    signing = {
      key = "~/.ssh/id_ed25519.pub";
      signByDefault = true;
    };

    # Integrations
    delta.enable = true;
    # difftastic.enable = true;
  };
}
