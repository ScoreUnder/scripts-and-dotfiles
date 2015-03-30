scriptencoding utf-8
set encoding=utf-8
set smartindent
set smarttab
set tabstop=4
set shiftwidth=4
set autoindent
set expandtab
set number
set wildmenu
set foldmethod=marker
set list listchars=tab:╾─,trail:·,nbsp:.
set background=dark
set omnifunc=syntaxcomplete#Complete
set completeopt=menu,preview,menuone
set hlsearch
set incsearch
set mouse=a
if match(&term, 'screen') >= 0 || match(&term, 'xterm') >= 0
    set term=xterm-256color
endif
syntax on
highlight Normal guibg=#000000 guifg=#FFFFFF
highlight Visual guibg=#222244
execute pathogen#infect()
filetype plugin indent on

" latex stuff
filetype plugin indent on
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"

nnoremap <space> za

nnoremap <leader>w :w!<cr>
nnoremap <leader>tn :tabnew<cr>
nnoremap <leader>tc :tabclose<cr>
nnoremap <leader>te :tabedit<space>
nnoremap <leader>j Ji;<esc>

"vnoremap > >gv
"vnoremap < <gv

autocmd BufEnter ?akefile* set noet nocindent
