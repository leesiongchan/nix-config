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
    rustup
    yaak
    ## K8S
    fluxcd
    # kdash
    kubectl
    talosctl

    # Entertainment
    ncspot

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
    granted.enable = true;
    # jq.enable = true;
    kubecolor.enable = true;
    mise.enable = false;
    navi.enable = true;
    npm.enable = true;
    ripgrep.enable = true;
    trippy.enable = true;
    zoxide.enable = true;
  };
}
