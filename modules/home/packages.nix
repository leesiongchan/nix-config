{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bashInteractive
    devenv
    dust
    dysk
    nixd
    nixfmt-rfc-style
    procs
    xh

    # Development
    yaak

    jdk25_headless
    pkl
    rustup

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
    jq.enable = true;
    navi.enable = true;
    ripgrep.enable = true;
    zoxide.enable = true;
  };
}
