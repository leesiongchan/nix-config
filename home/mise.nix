{ pkgs, ... }:

{
  # @ref https://github.com/nix-community/home-manager/blob/master/modules/programs/mise.nix
  programs.mise = {
    enable = true;

    globalConfig = {
      # plugins = {
      #   uv = "https://github.com/asdf-community/asdf-uv";
      # };
      settings = {
        experimental = true;
      };
      tools = {
        # bun = "latest";
        node = "lts";
        python = "3.13";
        # Make sure to install system dependencies.
        # @see https://github.com/rbenv/ruby-build/wiki#ubuntudebianmint
        # ruby = "latest";
        tanka = "latest;

        # Package Managers
        # pnpm = "latest";
        # uv = "latest";
        # Unable to install the lates (> 1.22.19) due to pgp issue.
        # @see https://github.com/twuni/asdf-yarn/issues/33
        # yarn = "1.22.19";

        # Tools
        # "awscli" = "latest";
        # "cargo:cargo-component" = "latest";
        # "cargo:cargo-lambda" = "latest";
        # "cargo:cargo-shuttle" = "latest";
        # "cargo:cargo-watch" = "latest";
        # "cargo:sccache" = "latest";
        # "cargo:trunk" = "latest";
        # "cargo:wasm-tools" = "latest";
        # "npm:@biomejs/biome" = "latest";
        # "npm:@bytecodealliance/jco" = "1.2.4";
        # "npm:@devcontainers/cli" = "latest";
        # "npm:@shopify/cli" = "latest";
        # "npm:aws-cdk" = "2.144.0";
        # "teleport-community" = "latest";
        # "terraform" = "latest";
      };
    };
  };
}
