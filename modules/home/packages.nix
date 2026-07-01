{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    doggo
    dust
    dysk
    jaq
    nixd
    nixfmt
    onefetch
    ouch
    pik
    procs
    sd
    serie
    tailspin
    tokei
    xh

    # Development
    devenv
    oha
    yaak

    # Fonts
    dm-mono
    dm-sans
    ibm-plex
    # jetbrains-mono

    # Networking
    gping
    sniffnet
  ];

  home.sessionPath = [
    "${config.home.homeDirectory}/.bun/bin"
    "${config.home.homeDirectory}/.npm/bin"
  ];

  programs = {
    bash.enable = true;
    bat.enable = true;
    bottom.enable = true;
    broot.enable = true;
    carapace.enable = true;
    delta = {
      enable = true;
      enableGitIntegration = true;
      enableJujutsuIntegration = true;
    };
    # difftastic = {
    #   enable = true;
    #   git = {
    #     enable = true;
    #     diffToolMode = true;
    #   };
    #   jujutsu.enable = true;
    # };
    eza.enable = true;
    fd.enable = true;
    fzf.enable = true;
    gpg.enable = true;
    # granted.enable = true;
    # jq.enable = true;
    kubecolor.enable = true;
    mise = {
      enable = true;
      # FIXME: skip tests until the test is fixed
      package = pkgs.mise.overrideAttrs (oldAttrs: {
        doCheck = false;
      });

      globalConfig = {
        tools = {
          bun = "latest";
          node = "latest";
          python = "latest";
          rust = "latest";

          uv = "latest";
          # k8s
          kubectl = "latest";
          "cargo:kdash" = "latest";
        };
      };
    };
    navi.enable = true;
    nix-index-database.comma.enable = true;
    npm.enable = true;
    ripgrep.enable = true;
    trippy.enable = true;
    zoxide.enable = true;
  };
}
