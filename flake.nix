{
  description = "My system configuration";

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    catppuccin.url = "github:catppuccin/nix";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hunk.url = "github:modem-dev/hunk";
    hunk.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    agent-skills.url = "github:Kyure-A/agent-skills-nix";
    agent-skills.inputs.nixpkgs.follows = "nixpkgs";
    # Not followed to nixpkgs: pins its own toolchain (Rust/Bun) and a
    # dedicated x86_64-darwin branch nixpkgs-unstable has since dropped.
    omp.url = "github:can1357/oh-my-pi";
    sops-nix.url = "github:mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    # Darwin-specific inputs
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    homebrew-core.url = "github:homebrew/homebrew-core";
    homebrew-core.flake = false;
    homebrew-cask.url = "github:homebrew/homebrew-cask";
    homebrew-cask.flake = false;
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    # Homebrew Taps
    # hewigovens-tap.url = "github:hewigovens/homebrew-tap";
    # hewigovens-tap.flake = false;
    lightpanda-browser-tap.url = "github:lightpanda-io/homebrew-browser";
    lightpanda-browser-tap.flake = false;
    # spotifly-tap.url = "github:ralph/homebrew-spotifly";
    # spotifly-tap.flake = false;
  };

  outputs =
    { nixpkgs, ... }@inputs:
    let
      mkSystem = import ./lib/mksystem.nix { inherit nixpkgs inputs; };
    in
    {
      darwinConfigurations.atlas = mkSystem "atlas" {
        system = "aarch64-darwin";
        user = "harvey";
        email = "harvey@snsoft.my";
      };
      darwinConfigurations.borisov = mkSystem "borisov" {
        system = "aarch64-darwin";
        user = "leesiongchan";
        email = "huger_outback.0s@icloud.com";
      };
      nixosConfigurations.oumuamua = mkSystem "oumuamua" {
        system = "x86_64-linux";
        user = "leesiongchan";
        email = "huger_outback.0s@icloud.com";
      };
    };
}
