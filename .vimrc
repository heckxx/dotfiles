" :PluginSearch foo - searches for foo; append `!` to refresh local cache
set nocompatible              " be iMproved, required
filetype off                  " required

syntax enable
colorscheme jellybeans
hi NonText ctermbg=NONE
hi Normal ctermbg=NONE

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'tpope/vim-sensible'					" Sensible vimrc
Plugin 'bling/vim-airline'
Plugin 'sjl/gundo.vim'						" Graphical Undo
Plugin 'altercation/vim-colors-solarized'	" Solarized
Plugin 'junegunn/vim-easy-align'			" easy align
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'scrooloose/syntastic'				" Syntastic
Plugin 'kien/ctrlp.vim'
Plugin 'ervandew/supertab'
" Plugin 'nanotech/jellybeans.vim'
" Plugin 'ardagnir/vimbed'					" For pterosaur

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline settings
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

" Mark over 80 lines
highlight ColorColumn ctermbg=darkblue
call matchadd('ColorColumn', '\%81v', 100)

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
"set list

" split navigation ctrl+direction
nnoremap <c-j> <c-w><c-j>
nnoremap <c-h> <c-w><c-h>
nnoremap <c-l> <c-w><c-l>
nnoremap <c-k> <c-w><c-k>
nnoremap j gj
nnoremap k gk
set splitbelow
set splitright

" Save as sudo when vim is not root
cmap w!! w !sudo tee > /dev/null %

" Key-bindings
inoremap jk <Esc>
nmap <Space> <leader>


" Plugin Key-bindings
nnoremap <leader>u :GundoToggle<CR>
vmap <Enter> <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)

" Syntastic checking:
let g:syntastic_cpp_checkers = ['clang_check', 'gcc']
let g:syntastic_c_checkers = ['clang_check', 'gcc']
" Centralized director for backup/swap files
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//
