{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    sops-nix.url = "github:mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    # Darwin-specific inputs
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    homebrew-core.url = "github:homebrew/homebrew-core";
    homebrew-core.flake = false;
    homebrew-cask.url = "github:homebrew/homebrew-cask";
    homebrew-cask.flake = false;
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs =
    {
      self,
      darwin,
      nixpkgs,
      home-manager,
      homebrew-cask,
      homebrew-core,
      nix-homebrew,
      sops-nix,
    }@inputs:
    let
      user = "leesiongchan";
      email = "huger_outback.0s@icloud.com";

      mkSystem = import ./lib/mksystem.nix {
        inherit
          nixpkgs
          inputs
          user
          email
          ;
      };
    in
    {
      darwinConfigurations.borisov = mkSystem "borisov" {
        system = "aarch64-darwin";
      };
      nixosConfigurations.oumuamua = mkSystem "oumuamua" {
        system = "x86_64-linux";
      };
    };
}
