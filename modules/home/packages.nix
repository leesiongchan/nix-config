{ pkgs, ... }:

{
  home.packages = with pkgs; [
    dust
    dysk
    jaq
    nixd
    nixfmt
    procs
    xh

    # AI
    github-mcp-server

    # Development
    devenv
    nodejs
    rustup
    yaak

    # K8S
    fluxcd
    kubectl
    talosctl

    # Fonts
    dm-mono
    dm-sans
    ibm-plex
    jetbrains-mono
  ];

  programs = {
    bash.enable = true;
    bat.enable = true;
    bottom.enable = true;
    broot.enable = true;
    carapace.enable = true;
    claude-code.enable = true;
    delta.enable = true;
    eza.enable = true;
    fd.enable = true;
    fzf.enable = true;
    gpg.enable = true;
    granted.enable = true;
    # jq.enable = true;
    kubecolor.enable = true;
    mise.enable = true;
    navi.enable = true;
    opencode.enable = true;
    ripgrep.enable = true;
    zoxide.enable = true;
  };
}
