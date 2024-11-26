{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    vscode-server.url = "github:nix-community/nixos-vscode-server";
  };

  outputs = inputs@{ nixpkgs, home-manager, vscode-server, ... }:
  let
    hostName = "Oumuamua";
    userName = "leesiongchan";
  in
  {
    nixosConfigurations = {
      ${hostName} = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          vscode-server.nixosModules.default
          (import ./configuration.nix { inherit hostName userName; })
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${userName} = import ./home.nix;

              extraSpecialArgs = { inherit inputs; };
              sharedModules = [
                inputs.sops-nix.homeManagerModules.sops
              ];
            };
          }
        ];
      };
    };
  };
}
