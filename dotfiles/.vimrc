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
set completeopt=menu,preview,menuone,longest
set hlsearch
set incsearch
set mouse=a
set shortmess=filnxtToOI
set formatlistpat=^\\s*\\d\\+\\.\\s\\+\\\|^[-*+]\\s\\+\\\|^\\[^\\ze[^\\]]\\+\\]:
set formatoptions+=jn
" Reindenting on every comment gets tired, fast. Disable:
set indentkeys-=0#
set nofsync
set lazyredraw

if has('nvim')
    set rtp^=/usr/share/vim/vimfiles
else
    set cryptmethod=blowfish2
    set swapsync=
    execute pathogen#infect()
endif

if match(&term, 'screen') >= 0 || match(&term, 'xterm') >= 0
    set term=xterm-256color
endif
syntax on
highlight Normal guibg=#000000 guifg=#FFFFFF
highlight Visual guibg=#222244
highlight LineNr ctermbg=235
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

function! HexDecSwap()
    py3 <<EOF
import vim
line = vim.current.line
win = vim.current.window
row, col = win.cursor

def hexspan(line, col):
    hexdigits = "0123456789abcdefABCDEF"
    if line[col:col+2].lower() == '0x':
        col += 2
    elif line[col:col+1].lower() == 'x':
        col += 1
    start, end = col, col
    while start > 0 and line[start] in hexdigits:
        start -= 1
    if line[start] not in hexdigits:
        start += 1
    while end < len(line) and line[end] in hexdigits:
        end += 1
    if start < 2 or line[start-2:start].lower() != '0x' or start >= end:
        return None
    return start, end

def decspan(line, col):
    start, end = col, col
    while start > 0 and line[start].isdigit():
        start -= 1
    if not line[start].isdigit():
        start += 1
    while end < len(line) and line[end].isdigit():
        end += 1
    if start >= end:
        return None
    return start, end

span = hexspan(line, col)
if span:
    # convert to dec
    start, end = span
    line = line[:start-2] + "%d" % int(line[start:end], 16) + line[end:]
    start -= 2
else:
    span = decspan(line, col)
    if span:
        start, end = span
        line = line[:start] + "0x%X" % int(line[start:end]) + line[end:]

if span:
    col = max(0, min(start, len(line) - 1))
    vim.current.line = line
    win.cursor = row, col
EOF
endfunction

command! Ass2Sbv silent call Ass2Sbv()

function AlwaysComplete()
    inoremap . .<C-X><C-O>
    inoremap # #<C-X><C-O>
endfunction

nnoremap <space> za
nnoremap g] :pts <c-r>=expand("<cword>")<cr><cr>

nnoremap <leader>w :w!<cr>
nnoremap <leader>tn :tabnew<cr>
nnoremap <leader>tc :tabclose<cr>
nnoremap <leader>te :tabedit<space>
nnoremap <leader>j Ji;<esc>
nnoremap <leader>m :wa!<cr>:mak<cr>
nnoremap <leader>x :call HexDecSwap()<cr>

nnoremap <silent> <F1> :ALEHover<cr>
inoremap <F1> <nop>

" Bullet point digraph
dig bp 8226

au BufNewFile,BufRead *.sls,*.yml setl ft=yaml sw=2 ts=2 indk-=0#
au BufNewFile,BufRead *.[ch] setl noet
au BufNewFile,BufRead *.go setl noet
autocmd BufEnter ?akefile* setl noet nocindent

let g:rainbow_active = 1
let g:UltiSnipsEditSplit="vertical"
let g:ycm_key_list_stop_completion = ['<C-y>', '<Cr>']
let g:Hexokinase_executable_path = "/usr/bin/hexokinase"
let g:Hexokinase_highlighters = [ 'backgroundfull' ]
let g:ale_fixers = {
\    'c': ['clang-format'],
\    'cpp': ['clang-format'],
\    'ocaml': ['ocamlformat'],
\    'scala': ['scalafmt'],
\    'dune': ['dune'],
\}
let g:ale_linters = {
\    'c': ['clangd'],
\}
let g:ale_c_build_dir_names = ['build', 'bin', '.']

imap <C-C>\ <Plug>(copilot-suggest)
imap <C-C>[ <Plug>(copilot-previous)
imap <C-C>] <Plug>(copilot-next)
