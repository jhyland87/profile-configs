" General Vim Settings {{{1
set nocompatible

filetype plugin indent on
syntax on

color distinguished
hi Search guibg=#336633 guifg=White
hi IncSearch gui=reverse guibg=bg guifg=fg

syntax match nonascii "[^\x00-\x7F]"
highlight nonascii guibg=Red ctermbg=1

let maplocalleader=","

set number
set ruler

set hlsearch
set incsearch
set smartcase
set ignorecase

set tabstop=8
set expandtab
set shiftwidth=4
set softtabstop=4
set smarttab
set autoindent
set smartindent
set list listchars=tab:>-,trail:·

set nowrap

set wildmode=longest:full
set wildmenu

set directory=~/.vim/swp//
set backupdir=~/.vim/backup//

set grepprg=grep\ -n\ -R\ --exclude=*.pyc\ --exclude-dir=.git\ $*\ /dev/null
" }}}1
" Filetype Settings {{{1
augroup filetype_settings
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType vim setlocal foldlevel=0
    autocmd BufWritePre *.{py,php,js} NomNom
augroup END
" }}}1
" Plugins {{{1
let g:CommandTMaxFiles=25000
let g:SuperTabNoCompleteAfter = ['^', '\s']
let g:syntastic_always_populate_loc_list = 1
let g:ctrlp_open_multiple_files = 'tjr'
au VimEnter,VimResized * let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:' . &lines

call pathogen#infect()
call pathogen#helptags()
" }}}1
" Force learning {{{1
" noremap <Up> <nop>
" noremap <Down> <nop>
" noremap <Left> <nop>
" noremap <Right> <nop>
" inoremap <Up> <nop>
" inoremap <Down> <nop>
" inoremap <Left> <nop>
" inoremap <Right> <nop>
" inoremap <esc> <nop>
" }}}1
" Edit/Source .vimrc {{{1
nnoremap <leader>E :split $MYVIMRC<cr>
nnoremap <leader>S :source $MYVIMRC<cr>
" }}}1
" Editing {{{1
inoremap jk <esc>
onoremap <silent> F :<C-U>normal! 0f(hviw<CR>
" }}}1
" Navigation {{{1
noremap H ^
noremap L g_
nnoremap / /\v
nnoremap ? ?\v
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
" }}}1
" Clist and Llist {{{1
noremap <Leader>l :clist<CR>
noremap <Leader>o :copen<CR>
noremap <Leader>x :cclose<CR>
noremap <Leader>[ :cprevious<CR>
noremap <Leader>] :cnext<CR>
noremap <LocalLeader>l :llist<CR>
noremap <LocalLeader>o :lopen<CR>
noremap <LocalLeader>x :lclose<CR>
noremap <LocalLeader>[ :lprevious<CR>
noremap <LocalLeader>] :lnext<CR>
" }}}1
" Flake8/Llist {{{1
noremap <LocalLeader><LocalLeader> :Errors<CR>
" }}}1
" Coverage shortcuts {{{1
noremap <LocalLeader>t :!coverage run --branch ../tests/test_runner.py<CR>:HighlightCoverage<CR>
noremap <LocalLeader>h :HighlightCoverage<CR>
" }}}1
" Cleanup and formatting {{{1
highlight SyntasticErrorLine guibg=#300000
highlight SyntasticWarningLine guibg=#202000
highlight! link SpellBad Error
highlight! link SpellCap ToDo
command! NomNom :%s/\s\+$\|\($\n\s*\)\+\%$//e
command! EDI :%s/\~//g
command! XML :%s/></></g
" }}}1
