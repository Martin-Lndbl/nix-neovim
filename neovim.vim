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

colorscheme spacecamp_transparent
" colorscheme twilight256
" colorscheme alduin
" colorscheme hybrid
" colorscheme afterglow
" colorscheme deus
" colorscheme one
" colorscheme gruvbox

autocmd BufRead,BufNewFile *.lytex set filetype=tex
