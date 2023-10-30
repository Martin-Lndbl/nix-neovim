{ pkgs
, lib
, config
, ...
}:
with config.programs.neovim.baseConfiguration;
{
  enable = true;
  vimAlias = true;
  extraConfig = ''
    set number
    set autoindent
    set tabstop=2
    set shiftwidth=2 smarttab
    set expandtab
    set mouse=a
    set undofile
    set undodir=$HOME/.tmp/undo
    set undolevels=1000
    set undoreload=1000
  '';

  extraLuaConfig = ''
    local function status_line()
      local file_name = "%-.16t"
      local modified = " %-m"
      local file_type = " %y"
      local right_align = "%="
      local line_no = "%10([%l/%L%)]"
      local pct_thru_file = "%5p%%"

      return string.format(
        "%s%s%s%s%s%s",
        file_name,
        modified,
        file_type,
        right_align,
        line_no,
        pct_thru_file
      )
    end

    vim.opt.statusline = status_line()
  '';
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
    rustfmt
    texlab
  ];
}
