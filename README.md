# NeoVim Homemanager Module

My way to keep synchronize my nvim config between different machines. But if you just get startet with nix and don't have a working nvim config, this might be helpful.

Mind that only including this Module into your [HomeManager](https://github.com/nix-community/home-manager) configuration won't work, since this module is expecting an attribute for extra configuration (currently only the colorscheme). I will provide a documentation for this configuration, but there is no guarantee for it to be up-to-date.

## Configuration

### Example configuration
Pass this attribute set as `extraSpecialArgs` to the `neovim.homeManagerModules.default` module.
```nix
extraSpecialArgs = {
  vimconf = {
    leader = ",";
    colorscheme = "spacecamp"; 
    extraPlugins = with pkgs.vimPlugins; [ awesome-vim-colorschemes ];
  };
};
```

### Configuration options
- `leader: string`
    - Custom mapleader.
- `colorscheme: string`
    - Vim colorscheme. 
    - Preinstalled: `[ "spacecamp" "spacecamp_lite" "spacecamp_transparent" ]`
    - See `extraPlugins` to add yours.
- `extraPlugins: list`
    - Add more plugins.
    
