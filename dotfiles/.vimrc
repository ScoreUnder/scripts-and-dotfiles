scriptencoding utf-8
set encoding=utf-8
set smartindent
set smarttab
set tabstop=4
set shiftwidth=4
set autoindent
set expandtab
set copyindent
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
set shortmess=filnxtToOI
set cryptmethod=blowfish2
set formatlistpat=^\\s*\\d\\+\\.\\s\\+\\\|^[-*+]\\s\\+\\\|^\\[^\\ze[^\\]]\\+\\]:
set formatoptions+=jn
" Reindenting on every comment gets tired, fast. Disable:
set indentkeys-=0#
set nofsync
set swapsync=

if match(&term, 'screen') >= 0 || match(&term, 'xterm') >= 0
    set term=xterm-256color
endif
syntax on
highlight Normal guibg=#000000 guifg=#FFFFFF
highlight Visual guibg=#222244
highlight LineNr ctermbg=235
execute pathogen#infect()
filetype plugin indent on

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

function DocMode()
    setlocal formatoptions+=a
    setlocal textwidth=72
endfunction

" latex stuff
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"

function! Ass2Sbv()
    v/^Dialogue:/d
    %s/^[^,]*,//
    %s/^\([^,]*\),\([^,]*\),[^,]*,[^,]*,[^,]*,[^,]*,[^,]*,[^,]*,\(.*\)$/\10,\20\r\3\r/
    %s/\\N/\r/g
    1
endfunction

command! Ass2Sbv silent call Ass2Sbv()

nnoremap <space> za
nnoremap g] :pts <c-r>=expand("<cword>")<cr><cr>

nnoremap <leader>w :w!<cr>
nnoremap <leader>tn :tabnew<cr>
nnoremap <leader>tc :tabclose<cr>
nnoremap <leader>te :tabedit<space>
nnoremap <leader>j Ji;<esc>
nnoremap <leader>m :wa!<cr>:mak<cr>

nnoremap <F1> <nop>
inoremap <F1> <nop>

" Bullet point digraph
dig bp 8226

au BufNewFile,BufRead *.sls,*.yml setl ft=yaml sw=2 ts=2 indk-=0#
au BufNewFile,BufRead *.[ch] setl noet
au BufNewFile,BufRead *.go setl noet
autocmd BufEnter ?akefile* setl noet nocindent
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['white',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'pink'],
    \ ]
