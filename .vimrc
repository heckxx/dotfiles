" _VIMPLUG
" _SYNTAX
" _PROGRAM
" __KEYBINDINGS
" _PLUGIN
" __AIRLINE
" __AUTOSAVE
" __SYNTASTIC
" _PLUGINKEYBINDINGS

set nocompatible              " be iMproved, required
filetype off  
" required
syntax enable
colorscheme jellybeans

"_VIMPLUG
" Plugin 'gmarik/Vundle.vim'
call plug#begin('~/.vim/plugins')
Plug 'bling/vim-airline'
Plug 'tpope/vim-sensible'                   " Sensible vimrc
Plug 'tpope/vim-surround'
Plug 'sjl/gundo.vim'                        " Graphical Undo
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'altercation/vim-colors-solarized' " Solarized
Plug 'junegunn/vim-easy-align'          " easy align
Plug 'nathanaelkane/vim-indent-guides'
Plug 'scrooloose/syntastic'             " Syntastic
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --omnisharp-completer' }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'irrationalistic/vim-tasks'
Plug 'lervag/vimtex'
Plug 'vim-scripts/vim-auto-save'
Plug 'nanotech/jellybeans.vim'
" Plugin 'ardagnir/vimbed'                  " For pterosaur
call plug#end()


"_SYNTAX
" transparent background
hi NonText ctermbg=NONE
hi Normal ctermbg=NONE
" Mark over 80 lines
highlight ColorColumn ctermbg=darkgrey
"set colorcolumn=81
call matchadd('ColorColumn','\%81v',100)
" Indent settings
set ts=4 sw=4 sts=4 et   "Spaces
" set ts=4 sw=4 sts=0 noet "Tabs
set list listchars=tab:▸\ ,trail:·
set smarttab
set visualbell
set number relativenumber numberwidth=2
set showcmd
set ignorecase smartcase
set hlsearch
set splitbelow
set splitright

"_PROGRAM
" centralized directory for backup/swap files
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//
" Save as sudo when vim is not root
cmap w!! w !sudo tee > /dev/null %

"__KEYBINDINGS
" split navigation ctrl+direction
nnoremap <c-j> <c-w><c-j>
nnoremap <c-h> <c-w><c-h>
nnoremap <c-l> <c-w><c-l>
nnoremap <c-k> <c-w><c-k>
nnoremap j gj
nnoremap k gk
inoremap jk <Esc>
nmap <Space> <leader>

"_PLUGIN

"__AIRLINE
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#syntastic#enabled=1
let g:airline_theme='dark'
let g:airline_powerline_fonts=1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'
" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
" let g:jellybeans_background_color_256='NONE'

"__AUTOSAVE
let g:auto_save = 1
let g:auto_save_no_updatetime = 1
let g:auto_save_in_insert_mode = 0
"__SYNTASTIC
let g:syntastic_cpp_checkers = ['clang_check', 'gcc']
let g:syntastic_c_checkers = ['clang_check', 'gcc']
let g:syntastic_python_checkers = ['/usr/sbin/python2']
"__ULTISNIPS
let g:UltiSnipsExpandTrigger="<c-Space>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

"_PLUGINKEYBINDINGS
nnoremap <leader>u :GundoToggle<CR>
vmap <Enter> <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)
