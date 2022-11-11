map ; :
let mapleader = ','
nnoremap <Leader>w <C-w>

set clipboard+=unnamedplus
set mouse=nv

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

set inccommand=split
