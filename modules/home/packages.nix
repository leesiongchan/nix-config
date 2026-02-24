{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bashInteractive
    devenv
    dust
    dysk
    jaq
    nixd
    nixfmt-rfc-style
    procs
    xh

    # AI
    cursor-cli

    # Development
    fluxcd
    kubectl
    rustup
    talosctl
    yaak

    # Fonts
    dm-mono
    dm-sans
    ibm-plex
    jetbrains-mono
  ];

  programs = {
    bat.enable = true;
    bottom.enable = true;
    broot.enable = true;
    carapace.enable = true;
    delta.enable = true;
    eza.enable = true;
    fd.enable = true;
    fzf.enable = true;
    gpg.enable = true;
    granted.enable = true;
    # jq.enable = true;
    mise.enable = true;
    navi.enable = true;
    opencode.enable = true;
    ripgrep.enable = true;
    zoxide.enable = true;
  };
}
