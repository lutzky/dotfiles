" Ohad's .vimrc

syntax on
set smartindent
set hlsearch
set incsearch
set tags+=~/.vim/systags
set fo+=r
set wildmenu

if &term == "xterm" || &term == "screen" || &term == "screen-256color" || &term == "xterm-256color"
    set t_Co=256
    let g:jellybeans_background_color_256="NONE"
    colorscheme jellybeans
endif

set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Plugin 'itchyny/lightline.vim'
Plugin 'gmarik/vundle'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'klen/python-mode'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-liquid'
Plugin 'airblade/vim-gitgutter'
Plugin 'jwhitley/vim-matchit'
Plugin 'nanotech/jellybeans.vim'
Plugin 'reinh/vim-makegreen'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-sleuth'

filetype plugin indent on

map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

map <F3> :NERDTreeToggle<CR>

augroup vimrc_autocommands
    au FileType python set si sw=4 ts=4 sts=4 et
    au FileType python compiler pyunit
    au FileType python highlight Excess ctermbg=DarkGrey guibg=DarkGrey
    au FileType python match Excess /\%80v.*/
    au FileType python set nowrap
    au FileType python set nonu
augroup END

au FileType haskell set et
au FileType ruby set si sw=2 ts=2 sts=2 et
au FileType eruby set si sw=2 ts=2 sts=2 et
au FileType cpp,cuda set si sw=2 ts=2 sts=2 et cindent
au FileType c set si sw=4 ts=4 sts=4 noet cindent
au FileType st set si sw=4 ts=4 sts=4 et
au FileType tex set si sw=2 ts=2 sts=2 et
au FileType ruby set si sw=2 ts=2 sts=2 et
au BufNewFile,BufRead *.ypp set ft=yacc
au FileType yacc set si sw=4 ts=4 sts=4 et smartindent
au FileType html set si sw=2 ts=2 sts=2 et
au FileType json set si sw=2 ts=2 sts=2 et
au FileType javascript set si sw=2 ts=2 sts=2 et

" colorcolumn will be set relative to textwidth, so filetypes with different
" textwidth won't get needlessly interrupted.
set textwidth=80
set colorcolumn=+1

" Github's new diff tool does soft-wrapping, and github staff recommend not
" hard-wrapping prose documents anymore.
au BufNewFile,BufRead *.md set ft=markdown
au FileType liquid,markdown set tw=0 linebreak nolist

function Comment_current(comment_symb)
    let curline = getline(".")
    if match(curline, "^\\s*" . a:comment_symb) != -1
        let comment_regex = "^\\(\\s*\\)" . a:comment_symb . " \\?"
        let new_curline = substitute(curline, comment_regex, "\\1", "")
    else
        let new_curline = substitute(curline, "^\\s*", "\\0" . a:comment_symb . " " , "")
    endif
    call setline(".", new_curline)
endfunction

au FileType ruby,python map # :call Comment_current("#")<CR>j
au FileType c,cpp map # :call Comment_current("//")<CR>j

let mapleader = ","

map <Leader>t :Make<CR>
map <Leader>r :Make run<CR>
map <Leader>c :cclose<CR>:lclose<CR>

" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

set mouse=a

let g:Tex_UseEditorSettingInDVIViewer = 1
let g:Tex_Folding = 1
let g:Tex_CompileRule_dvi = 'latex -interaction=nonstopmode -src-specials $*'
let g:Tex_ViewRule_pdf = 'evince'
let g:Tex_ViewRule_ps = 'evince'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Imap_FreezeImap = 0 " So it shows up in tab-completion

set wildmode=longest,list

autocmd BufNewFile,BufRead COMMIT_EDITMSG set filetype=gitcommit
autocmd BufNewFile,BufRead config.yml set ts=2 sts=2 et sw=2

" Python-mode
" Activate rope
" Keys:
" K             Show python docs
" <Ctrl-Space>  Rope autocomplete
" <Ctrl-c>g     Rope goto definition
" <Ctrl-c>d     Rope show documentation
" <Ctrl-c>f     Rope find occurrences
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)
let g:pymode_rope = 1

" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'

"Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
" Auto check on save
let g:pymode_lint_write = 1

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1

set laststatus=2

let g:ycm_confirm_extra_conf = 0

set splitright

" Highlight unwanted characters
set list

map tn :tabnext<CR>
map tp :tabprev<CR>
map <C-t> :tabnew<CR>

" Extra laziness for ex-:
map ; :

let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
      \ },
      \   'component_function': { 'fugitive': 'fugitive#statusline' }
      \ }

if &t_Co == 256
    let g:lightline.colorscheme = 'jellybeans'
endif
