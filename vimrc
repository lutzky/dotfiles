" Ohad's .vimrc

syntax on
set smartindent
set hlsearch
set incsearch
set tags+=~/.vim/systags
set fo+=r
set wildmenu

if &term == "xterm"
	set t_Co=256
	colorscheme default
	set bg=dark
elseif &term == "linux"
	set bg=light " Counterintuitive, but seems to help
endif

hi normal guibg=black guifg=white

filetype plugin indent on

au FileType haskell set et
au FileType ruby set si sw=2 ts=2 sts=2 et
au FileType eruby set si sw=2 ts=2 sts=2 et
au FileType cpp set si sw=4 ts=4 sts=4 et cindent
au FileType cuda set si sw=4 ts=4 sts=4 et cindent
au FileType c set si sw=4 ts=4 sts=4 noet cindent
au FileType st set si sw=4 ts=4 sts=4 et
au FileType tex set si sw=2 ts=2 sts=2 et
au FileType python set si sw=4 ts=4 sts=4 et
au FileType ruby set si sw=2 ts=2 sts=2 et
au BufNewFile,BufRead *.ypp set ft=yacc
au FileType yacc set si sw=4 ts=4 sts=4 et smartindent

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
