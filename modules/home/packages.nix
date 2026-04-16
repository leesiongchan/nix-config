{ pkgs, ... }:

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
    xh

    # AI
    rtk

    # Development
    devenv
    nodejs
    rustup
    yaak
    oha
    ## K8S
    fluxcd
    # kdash
    kubectl
    talosctl

    # Fonts
    dm-mono
    dm-sans
    ibm-plex
    # jetbrains-mono

    # Networking
    gping
    sniffnet
  ];

  programs = {
    bash.enable = true;
    bat.enable = true;
    bottom.enable = true;
    broot.enable = true;
    carapace.enable = true;
    claude-code.enable = true;
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
    opencode.enable = true;
    ripgrep.enable = true;
    trippy.enable = true;
    zoxide.enable = true;
  };
}
