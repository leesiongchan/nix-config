{ nixpkgs, inputs }:

hostname:
{
  system,
  user,
  email,
}:

let
  isDarwin = system == "aarch64-darwin";

  homeDir = if isDarwin then "/Users/${user}" else "/home/${user}";

  hostConfig = ../hosts/${hostname};
  moduleConfig = if isDarwin then ../modules/darwin else ../modules/nixos;

  # FIXME: no darwin modules yet
  # catppuccinModules = if isDarwin then inputs.catppuccin.darwinModules else inputs.catppuccin.nixosModules;
  homeManagerModules =
    if isDarwin then inputs.home-manager.darwinModules else inputs.home-manager.nixosModules;
  sopsModules = if isDarwin then inputs.sops-nix.darwinModules else inputs.sops-nix.nixosModules;

  systemFunc = if isDarwin then inputs.darwin.lib.darwinSystem else nixpkgs.lib.nixosSystem;
in
systemFunc {
  inherit system;

  modules = [
    {
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
      nixpkgs.config.allowUnfree = true;
    }

    (if isDarwin then inputs.nix-homebrew.darwinModules.nix-homebrew else { })
    (
      if isDarwin then
        {
          nix-homebrew = {
            inherit user;
            enable = true;

            enableRosetta = false;
            mutableTaps = false;
            taps = {
              "homebrew/homebrew-core" = inputs.homebrew-core;
              "homebrew/homebrew-cask" = inputs.homebrew-cask;
              # "updatest/tap" = inputs.updatest-tap;
            };
          };
        }
      else
        { }
    )
    sopsModules.sops
    # catppuccinModules.catppuccin
    homeManagerModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.${user} = ../modules/home;
        extraSpecialArgs = { inherit homeDir user email; };
        sharedModules = [
          inputs.catppuccin.homeModules.catppuccin
          inputs.sops-nix.homeManagerModules.sops
        ];
      };
    }

    moduleConfig
    hostConfig
  ];
  specialArgs = { inherit homeDir hostname user; };
}
