{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    doggo    # DNS client
    dust     # Disk usage analyzer
    dysk     # Disk usage/filesystem info tool
    jaq      # jq clone written in Rust
    nixd     # Nix language server
    nixfmt   # Nix code formatter
    onefetch # Git repository summary tool
    ouch     # Archive/compression tool
    pik      # Interactive process picker/killer
    procs    # Modern replacement for ps
    proxelar # Programmable MITM proxy for HTTP/HTTPS traffic
    sd       # Find & replace CLI (sed alternative)
    serie    # Git commit graph visualizer
    tailspin # Log file highlighter
    tokei    # Code statistics tool
    xh       # HTTP client (httpie alternative)

    # Development
    # devenv
    oha  # HTTP load testing tool
    yaak # API client

    # Fonts
    dm-mono
    dm-sans
    ibm-plex
    # jetbrains-mono
    martian-mono

    # Networking
    gping    # Ping with a graph
    sniffnet # Network traffic monitor
  ];

  home.sessionPath = [
    "${config.home.homeDirectory}/.bun/bin"
    "${config.home.homeDirectory}/.npm/bin"
  ];

  programs = {
    aria2.enable = true;
    bash.enable = true;
    bat.enable = true;
    bottom.enable = true;
    broot.enable = true;
    carapace.enable = true;
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
        # libz-ng-sys needs cmake at build time; nixpkgs only lists it in nativeCheckInputs
        nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ [ pkgs.cmake ];
      });

      globalConfig = {
        tools = {
          # Languages
          bun = "latest";
          node = "latest";
          python = "latest";
          rust = "latest";

          # Package Managers
          aube = "latest";
          cargo-binstall = "latest";
          uv = "latest";

          dagger = "latest";
        };
      };
    };
    navi.enable = true;
    nix-index-database.comma.enable = true;
    # npm.enable = true;
    ripgrep.enable = true;
    tealdeer.enable = true;
    trippy.enable = true;
    zoxide.enable = true;
  };
}
