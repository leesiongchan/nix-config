1. Install dependencies

```sh
xcode-select --install
```

2. Install Nix

```sh
curl -fsSL https://install.determinate.systems/nix | sh -s -- install --determinate
```

3. Install [nix-darwin](https://github.com/nix-darwin/nix-darwin)

```sh
# https://github.com/nix-darwin/nix-darwin?tab=readme-ov-file#step-2-installing-nix-darwin
sudo nix run nix-darwin/nix-darwin-25.05#darwin-rebuild -- switch
```

4. (Optional) Convert an SSH key to an age key

```sh
export SOPS_AGE_KEY_PATH=~/.config/sops/age
mkdir -p "$SOPS_AGE_KEY_FILE"
nix-shell -p ssh-to-age --run "ssh-to-age -private-key -i <ssh_key_path> > '$SOPS_AGE_KEY_FILE/keys.txt'"
```

5. Apply the configuration

```sh
sudo darwin-rebuild switch --flake .#<host>
# or linux
nix-rebuild switch --flake .#<host>
```
