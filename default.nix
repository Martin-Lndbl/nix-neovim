self:
{ pkgs
, lib
, config
, vimconf ? {
    colorscheme = "spacecamp";
  }
, ...
}:
{
  programs.neovim = {
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

      let mapleader=","

      " Nerdtree
      let g:NERDTreeDirArrowExpandable="+"
      let g:NERDTreeDirArrowCollapsible="+"
      nnoremap <leader>k :NERDTreeFocus<CR>
      nnoremap <leader>t :NERDTreeToggle<CR>
      nnoremap <leader>f :NERDTreeFind<CR>

      " Undotree
      nnoremap <leader>u :UndotreeToggle<CR>

      " Tagbar
      nnoremap <leader>b :TagbarToggle<CR>

      " Telescope
      nnoremap <leader>pp :lua require('telescope.builtin').builtin({ include_extensions = true })<CR>
      nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<CR>
      nnoremap <leader>ff <cmd>lua require('telescope.builtin').live_grap()<CR>
      nnoremap <leader>ff <cmd>lua require('telescope.builtin').buffers()<CR>
      nnoremap <leader>ff <cmd>lua require('telescope.builtin').help_tags()<CR>
      nnoremap <silent> <leader>pc :call TelescopeCurrentComposerPackage()<CR>

      colorscheme ${vimconf.colorscheme}
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
      texlab
    ];
  };
}
