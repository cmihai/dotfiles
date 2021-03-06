" Load Vundle
set nocompatible
filetype off

let vundle=0
if isdirectory($HOME . '/.vim/bundle/vundle')
    set rtp+=~/.vim/bundle/vundle
    let vundle=1
elseif isdirectory($HOME . '/.vim/bundle/Vundle.vim')
    set rtp+=~/.vim/bundle/Vundle.vim
    let vundle=1
endif

if vundle == 1
    call vundle#begin()

    Plugin 'pangloss/vim-javascript'
    Plugin 'Glench/Vim-Jinja2-Syntax'
    Plugin 'ctrlpvim/ctrlp.vim'
    Plugin 'aaronj1335/underscore-templates.vim'
    Plugin 'klen/python-mode'
    Plugin 'tpope/vim-rsi'
    Plugin 'mileszs/ack.vim'
    Plugin 'altercation/vim-colors-solarized'

    call vundle#end()

    " Ctrl-P plugin
    let g:ctrlp_custom_ignore = {
    \ 'dir': '\v[\/](build|node_modules|venv)$',
    \ 'file': '\.pyc$'
    \ }

    " Python-mode plugin
    set nofoldenable
    let g:pymode_warnings = 0
    let g:pymode_rope_lookup_project = 0
    let g:pymode_rope_autoimport = 0
    let g:pymode_rope = 0

    " Ack plugin
    let g:ack_default_options = " -H --nocolor --nogroup --column"

    " Solarized options
    syntax enable
    set background=dark
    colorscheme solarized
endif

" Syntax coloring
syntax on

" 4-space tabs
set expandtab tabstop=4 shiftwidth=4 smarttab

" Line numbering
set number
nnoremap \n :setlocal number!<CR>

" Paste mode
nnoremap \p :setlocal paste!<CR>

" Indenting
set autoindent
nnoremap \i :setlocal smartindent!<CR>
filetype plugin indent on

" Search
let @/=''
set hlsearch incsearch
nnoremap \h :setlocal hlsearch!<CR>
nnoremap / :setlocal hlsearch<CR>/
nnoremap * :setlocal hlsearch<CR>*
nnoremap Y y$

" Don't clutter current dir with swapfiles
if !isdirectory($HOME.'/.vim/swapfiles')
    silent !mkdir -p ~/.vim/{swapfiles,backups,undo} > /dev/null 2>&1
endif

set directory=~/.vim/swapfiles//
set backupdir=~/.vim/backups//

if version >= 703
    set undodir=~/.vim/undo//
endif

" Mappings
nnoremap <F5> :%s/\s\+$//g<CR>
nnoremap ci< ?>?s+1<cr>c/<<cr>
nnoremap ci> ?>?s+1<cr>c/<<cr>
inoremap <C-w> <Esc><C-w>

if &readonly == 1
    map q :q<CR>
    map <Space> <PageDown>
endif

" Misc
" set autochdir
set fo+=t

function! SaveAndQuit()
    mksession! ~/.vim/session.vim
    qall
endfunction
command! QS call SaveAndQuit()

" File types
au FileType python
            \ setlocal textwidth=79 colorcolumn=80 |
            \ highlight ColorColumn ctermbg=red
au! BufEnter,BufNew *.py
            \ nnoremap <buffer> <F9> :!flake8 %<CR>
" au! BufEnter,BufNew *.jinja2
" au BufEnter,BufNew *.jinja2 setlocal filetype=jinja
au BufRead,BufNewFile *.md setlocal filetype=markdown
au BufEnter,BufNew *.js
            \ setlocal filetype=javascript |
            \ nnoremap <buffer> <F9> :!jshint %<CR>
au! BufEnter,BufNew *.tpl
au BufEnter,BufNew *.tpl
                   \ setlocal filetype=html syntax=underscore_template |
                   \ setlocal tabstop=4 shiftwidth=4
