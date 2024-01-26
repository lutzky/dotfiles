map ; :
let mapleader = ','
nnoremap <Leader>w <C-w>

set clipboard+=unnamedplus
set mouse=nv

if !empty($TMUX)
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
Plug 'itchyny/lightline.vim'
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
    let g:jellybeans_background_color_256="NONE"
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
