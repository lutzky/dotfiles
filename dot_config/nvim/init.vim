" Extra laziness for ex-:
map ; :
let mapleader = ','

runtime init.work.vim

" Workaround for Ctrl-W not working in browser tabs
nnoremap <Leader>w <C-w>

set clipboard+=unnamedplus
set mouse=nv

if !empty($TMUX)
    " Use load-buffer -w to copy to OSC52 as well; https://github.com/neovim/neovim/issues/14545
    let g:clipboard = {
          \   'name': 'myClipboard',
          \   'copy': {
          \      '+': ['tmux', 'load-buffer', '-w', '-'],
          \      '*': ['tmux', 'load-buffer', '-w', '-'],
          \    },
          \   'paste': {
          \      '+': ['tmux', 'save-buffer', '-'],
          \      '*': ['tmux', 'save-buffer', '-'],
          \   },
          \   'cache_enabled': 1,
          \ }
endif

set inccommand=split

" Requires https://github.com/junegunn/vim-plug
call plug#begin()

Plug 'airblade/vim-gitgutter'
Plug 'dag/vim-fish'
Plug 'google/vim-jsonnet'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'khaveesh/vim-fish-syntax'
Plug 'nanotech/jellybeans.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'

call plug#end()

let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
      \ },
      \   'component_function': { 'fugitive': 'fugitive#statusline' }
      \ }

if &t_Co == 256
    let g:lightline.colorscheme = 'jellybeans'
    let g:jellybeans_use_term_italics = 1
    let g:jellybeans_overrides = {
                \    'background': { 'guibg': 'none' },
                \}

    colorscheme jellybeans
endif

" You usually only want to paste once. Better get used to C-[ rather than C-c.
autocmd InsertLeave *
    \ if &paste == 1 |
    \      set nopaste |
    \ endif

" For those situations where C-w is unavailable
noremap <Leader>w <C-w>

" Extra laziness for ex-:
map ; :

set splitright

" Highlight unwanted characters
set list

set laststatus=2
