self:
{ pkgs
, lib
, config
, ...
}:
{
 programs.neovim =  {
  enable = true;
  vimAlias = true;
  extraConfig = builtins.readFile ./neovim.vim;
  extraLuaConfig = builtins.readFile ./neovim.lua;
  plugins = import ./plugins {
    inherit pkgs config;
  };
  extraPackages = with pkgs; [
    sumneko-lua-language-server
    nodePackages.bash-language-server
    nodePackages.pyright
    nodePackages.eslint_d
    nodePackages.prettier_d_slim
    ccls
    rnix-lsp
    rust-analyzer
    texlab
  ];
};
}
