{ pkgs, ... }:

{
  home.packages = with pkgs; [
    du-dust
    dysk
    procs
    nixd
  ];

  programs = {
    bat.enable = true;
    bottom.enable = true;
    broot.enable = true;
    carapace.enable = true;
    eza.enable = true;
    fd.enable = true;
    fzf.enable = true;
    gitui.enable = true;
    gpg.enable = true;
    granted.enable = true;
    jq.enable = true;
    navi.enable = true;
    ripgrep.enable = true;
    ssh.enable = true;
    zoxide.enable = true;
  };
}
