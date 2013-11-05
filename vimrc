" Ohad's .vimrc

syntax on
set smartindent
set hlsearch
set incsearch
set tags+=~/.vim/systags
set fo+=r
set wildmenu

if &term == "xterm" || &term == "screen"
	set t_Co=256
	colorscheme jellybeans
	set bg=dark
endif

set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'bling/vim-airline'
Bundle 'gmarik/vundle'
Bundle 'scrooloose/nerdtree'
Bundle 'klen/python-mode'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-liquid'
Bundle 'vim-scripts/OmniCppComplete'
Bundle 'airblade/vim-gitgutter'
Bundle 'jwhitley/vim-matchit'

filetype plugin indent on

map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

map <F3> :NERDTreeToggle<CR>

augroup vimrc_autocommands
    au FileType python set si sw=4 ts=4 sts=4 et
    au FileType python highlight Excess ctermbg=DarkGrey guibg=DarkGrey
    au FileType python match Excess /\%80v.*/
    au FileType python set nowrap
    au FileType python set nonu
augroup END

au FileType haskell set et
au FileType ruby set si sw=2 ts=2 sts=2 et
au FileType eruby set si sw=2 ts=2 sts=2 et
au FileType cpp set si sw=4 ts=4 sts=4 et cindent
au FileType cuda set si sw=4 ts=4 sts=4 et cindent
au FileType c set si sw=4 ts=4 sts=4 noet cindent
au FileType st set si sw=4 ts=4 sts=4 et
au FileType tex set si sw=2 ts=2 sts=2 et
au FileType ruby set si sw=2 ts=2 sts=2 et
au BufNewFile,BufRead *.ypp set ft=yacc
au FileType yacc set si sw=4 ts=4 sts=4 et smartindent
au FileType html set si sw=2 ts=2 sts=2 et
au FileType json set si sw=2 ts=2 sts=2 et
au FileType javascript set si sw=2 ts=2 sts=2 et

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

au FileType python compiler nose

let mapleader = ","
map <Leader>t :MakeGreen<CR>

set mouse=a

let g:Tex_UseEditorSettingInDVIViewer = 1
let g:Tex_Folding = 1
let g:Tex_CompileRule_dvi = 'latex -interaction=nonstopmode -src-specials $*'
let g:Tex_ViewRule_pdf = 'evince'
let g:Tex_ViewRule_ps = 'evince'
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

" Don't autofold code
let g:pymode_folding = 0

set laststatus=2
let g:airline#extensions#tabline#enabled = 1

map tn :tabnext<CR>
map tp :tabprev<CR>
map <C-t> :tabnew<CR>
