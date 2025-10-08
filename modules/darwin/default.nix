{ ... }:

{
  imports = [
    ./configuration.nix
    ./brew.nix
    ./home.nix
  ];

  # We use `--determinate` flag which will use Determinate distribution.
  # Determinate manages the Nix installation itself so we need to disable it.
  nix.enable = false;
}
