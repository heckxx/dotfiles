" _VIMPLUG
" _SYNTAX
" __FILE_SPECIFIC
" _PROGRAM
" __KEYBINDINGS
" _PLUGIN
" __AIRLINE
" __AUTOSAVE
" __SYNTASTIC
" __TASKS
" __ULTISNIPS
" __UNDOTREE
" _PLUGINKEYBINDINGS

set nocompatible              " be iMproved, required
" required
syntax enable
colorscheme jellybeans

"_VIMPLUG
" Plugin 'gmarik/Vundle.vim'
call plug#begin('~/.vim/plugins')
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-sensible'                   " Sensible vimrc
Plug 'tpope/vim-surround'
Plug 'mbbill/undotree'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'octol/vim-cpp-enhanced-highlight' " cpp syntax highlighting
Plug 'junegunn/vim-easy-align'          " easy align
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'                     " fuzzy finder
Plug 'nathanaelkane/vim-indent-guides'
Plug 'w0rp/ale'
Plug 'maralla/completor.vim'
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --omnisharp-completer' }
Plug 'irrationalistic/vim-tasks'
Plug 'lervag/vimtex'
Plug 'vim-scripts/vim-auto-save'
Plug 'nanotech/jellybeans.vim'
Plug 'beloglazov/vim-online-thesaurus'
" Plug 'chrisbra/Colorizer'
" Plugin 'ardagnir/vimbed'                  " For pterosaur
call plug#end()


"_SYNTAX
" transparent background
hi NonText ctermbg=NONE
hi Normal ctermbg=NONE
" Mark over 80 lines
highlight ColorColumn ctermbg=darkgrey
" set colorcolumn=81
autocmd FileType python call matchadd('ColorColumn','\%81v',100)
" Indent settings
set ts=4 sw=4 sts=4 et   "Spaces
set linebreak
" set ts=4 sw=4 sts=0 noet "Tabs
set list listchars=tab:▸\ ,trail:·
set smarttab
set modeline
set visualbell
set number relativenumber numberwidth=2
set showcmd
set ignorecase smartcase
set hlsearch
set splitbelow
set splitright
"__FILE_SPECIFIC
" spellcheck for notes
autocmd BufRead,BufNewFile notes setlocal spell spelllang=en_us spellcapcheck=''
autocmd FileType tex inoremap " ``
autocmd FileType tex setlocal spell spellcapcheck=''
autocmd FileType SIGKILL inoremap E ▘
autocmd FileType SIGKILL inoremap O ⊙
autocmd FileType SIGKILL inoremap I i

"_PROGRAM
" centralized directory for backup/swap files
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
" Save as sudo when vim is not root
cmap w!! w !sudo tee > /dev/null %
set hidden
let g:netrw_liststyle=3

"__KEYBINDINGS
" split navigation ctrl+direction
nnoremap <c-j> <c-w><c-j>
nnoremap <c-h> <c-w><c-h>
nnoremap <c-l> <c-w><c-l>
nnoremap <c-k> <c-w><c-k>
nnoremap j gj
nnoremap k gk
inoremap jk <esc>
nmap <space> <leader>
nmap <leader>s 1z=

"_PLUGIN

"__AIRLINE
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#syntastic#enabled=1
let g:airline#extensions#tabline#buffer_nr_show=1
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
call airline#parts#define_function('ALE', 'ALEGetStatusLine')
call airline#parts#define_condition('ALE', 'exists("*ALEGetStatusLine")')
let g:airline_section_error = airline#section#create_right(['ALE'])
" let g:jellybeans_background_color_256='NONE'

"__ALE
let g:ale_lint_delay = 500

"__AUTOSAVE
let g:auto_save = 0
let g:auto_save_no_updatetime = 1
let g:auto_save_in_insert_mode = 0
"__CTRLP
"
"__COLORIZER
"let g:colorizer_auto_filetype='css,html,javascript'
"
"__FZF
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
" Insert mode completion
imap <tab>k <plug>(fzf-complete-word)
imap <tab>f <plug>(fzf-complete-path)
imap <tab>j <plug>(fzf-complete-file-ag)
imap <tab>l <plug>(fzf-complete-line)
" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
" Advanced customization using autoload functions
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})"

"__SYNTASTIC
"let g:syntastic_cpp_compiler_options = '$(pkg-config gtkmm-3.0 --cflags --libs)'
"let g:syntastic_c_compiler_options = '$(pkg-config gtk+-3.0 --cflags --libs)'
"__TASKS
let g:TasksAttributeMarker = '#'
"__ULTISNIPS
let g:UltiSnipsExpandTrigger="<c-Space>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
"__UNDOTREE
if has("persistent_undo")
    set undodir=~/.vim/undo/
    set undofile
endif
let g:undotree_WindowLayout = 2
let g:undotree_SetFocusWhenToggle = 1

"_PLUGINKEYBINDINGS
nnoremap <leader>u :UndotreeToggle<CR>
vmap <Enter> <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)
