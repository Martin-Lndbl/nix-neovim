> [!WARNING]
> This is out of date and might not work with newer nixpkgs versions.
> My current NeoVim config can be found [here](https://github.com/Martin-Lndbl/nixos-config/tree/master/hm/programs/nvim).
> An up-to-date module does not exist since it defies the purpose of modules.

# NeoVim Homemanager Module

Module providing extensive neovim configuration. For everyone who doesn't want to start configuring neovim from scratch. Custom configuration can be added using the [HomeManager API](https://nix-community.github.io/home-manager/options.html).

## Quick start:
- Include the module into your `homeConfiguration`.
- Set `programs.neovim.baseConfiguration.enable = true` somewhere in your configuration.

## Configuration options

For up-to-date configuration options check [module.nix](https://github.com/Martin-Lndbl/nix-neovim-module/blob/master/module.nix).

- Only few configuration options are provided for the preconfigured part, since adding onto this configuration can be done by using the HomeManager API.  
- Change the `mapleader` with: `programs.neovim.baseConfiguration.leader`
- Change the `colorscheme` with `programs.neovim.baseConfiguration.colorscheme`

### Example configuration
Paste this code somewhere into your HomeManager configuration.
```nix
programs.neovim.baseConfiguration = {
  enable = true;
  leader = "l";
  colorscheme = "spacecamp_transparent"; 
};
```
