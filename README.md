<p align="center">
  <img src="./.github/assets/neovim-logo.svg" width="200" />
</p>

# NixVim Configuration

## How to run

To run the configuration, you can type the following:

```bash
nix run github:wueestry/nixvim-config
```

## How to include as package

To include the configuration as a replacement for Neovim, you first need to add it as an input on your system
```
inputs.nixvim.url = "github:wueestry/nixvim-config"
```

Then you can input this in your configuration.nix (be sure that you inherit inputs from your flake)
```
  environment = {
    systemPackages = with pkgs; [
      inputs.nixvim.packages.${system}.default
    ];
  };
```

## Configuring

To start configuring, just add or modify the nix files in `./config`.
If you add a new configuration file, remember to add it to the
[`config/default.nix`](./config/default.nix) file

## Testing your new configuration

To test your configuration simply run the following command

```
nix run .
```