{
  pkgs,
  user,
  email,
  ...
}:

{
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    enableJujutsuIntegration = true;
  };
  # programs.difftastic = {
  #   enable = true;

  #   git = {
  #     enable = true;
  #     diffToolMode = true;
  #   };
  #   jujutsu.enable = true;
  # };

  # @ref https://github.com/nix-community/home-manager/blob/master/modules/programs/git.nix
  programs.git = {
    enable = true;

    settings = {
      # some come from https://jvns.ca/blog/2024/02/16/popular-git-config-options/
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
        ssh.allowedSignersFile = "~/.config/git/allowed_signers";
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

      user = {
        email = email;
        name = user;
      };
    };
    signing = {
      key = "~/.ssh/id_ed25519.pub";
      signByDefault = true;
    };
  };
  xdg.configFile."git/allowed_signers".text = ''
    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKcOCegegJ9lnPtt0S8cB09hU4VK4qFvhf5NJhUKBZgJ
  '';

  # @ref https://github.com/nix-community/home-manager/blob/master/modules/programs/jujutsu.nix
  programs.jujutsu = {
    enable = true;

    settings = {
      signing = {
        behavior = "own";
        backend = "ssh";
        key = "~/.ssh/id_ed25519.pub";
      };
      user = {
        name = user;
        email = email;
      };
    };
  };
  programs.jjui.enable = true;

  programs.gh = {
    enable = true;

    settings.git_protocol = "ssh";
  };

  # @ref https://github.com/modem-dev/hunk/blob/main/nix/README.md
  programs.hunk = {
    enable = true;

    enableClaudeIntegration = true;
  };

  # @ref https://github.com/nix-community/home-manager/blob/master/modules/programs/worktrunk.nix
  programs.worktrunk = {
    enable = true;

    # nixpkgs' worktrunk package moved its Claude Code skills to
    # $out/share/skills/worktrunk/* via installAgentSkills, but home-manager's
    # worktrunk module still hardcodes the old $out/skills/* path. Shim it back
    # until home-manager catches up.
    # @ref https://github.com/NixOS/nixpkgs/pull/558216
    # @ref https://github.com/NixOS/nixpkgs/issues/547426
    package = pkgs.symlinkJoin {
      name = "worktrunk-with-legacy-skills-path";
      paths = [ pkgs.worktrunk ];
      postBuild = ''
        mkdir -p $out/skills
        ln -s $out/share/skills/worktrunk/worktrunk $out/skills/worktrunk
        ln -s $out/share/skills/worktrunk/wt-switch-create $out/skills/wt-switch-create
      '';
      meta = pkgs.worktrunk.meta;
    };

    claudeCodeIntegration = {
      enable = true;

      statusLine = false;
    };
  };
}
