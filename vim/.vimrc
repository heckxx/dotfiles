set nocompatible

"""""""""""
" Plugins "
"""""""""""
" Auto install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugins')
Plug '907th/vim-auto-save'
  let g:auto_save = 0
  let g:auto_save_no_updatetime = 1
  let g:auto_save_in_insert_mode = 0
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'                 " fuzzy finder
  "__FZF
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
  inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '14%'})"
Plug 'luochen1990/rainbow'
  let g:rainbow_active = 1
Plug 'markonm/traces.vim' " Command preview
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
  nmap <silent><C-p> :LspCodeAction<CR>
  nmap <silent>K :LspHover<CR>
  nmap <silent>gr :LspRename
  nmap <silent>gd <Plug>(lcn-explain-error)
  nmap <silent>gu <Plug>(lcn-references)
  let g:lsp_async_completion = 1
  let g:lsp_signs_enabled = 1
  let g:lsp_diagnostics_echo_cursor = 1
  let g:asyncomplete_auto_popup = 1
  "nmap <silent><C-]> <Plug>(lcn-definition)
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  "let g:deoplete#enable_at_startup = 1
"Plug 'autozimu/LanguageClient-neovim', {
      "\'branch': 'next',
      "\ 'do': 'bash install.sh',
      "\ }
Plug 'octol/vim-cpp-enhanced-highlight'
  let g:cpp_class_scope_highlight = 1
  let g:cpp_member_variable_highlight = 1
  let g:cpp_class_decl_highlight = 1
  let g:cpp_posix_standard = 1
  let g:cpp_experimental_template_highlight = 1
Plug 'mhinz/vim-signify'
  let g:signify_sign_change = '~'
  highlight SignColumn ctermbg=NONE cterm=NONE guibg=NONE gui=NONE
  highlight SignifySignAdd ctermfg=LightGreen guifg=LightGreen
  highlight SignifySignDelete ctermfg=LightRed guifg=LightRed
  highlight SignifySignChange ctermfg=LightBlue guifg=LightBlue
Plug 'aserebryakov/vim-todo-lists'
Plug 'beloglazov/vim-online-thesaurus'
Plug 'embear/vim-foldsearch'
Plug 'honza/vim-snippets'
Plug 'ericcurtin/CurtineIncSw.vim'
  nmap <c-x> :call CurtineIncSw()<CR>
Plug 'kshenoy/vim-signature'
Plug 'blueyed/vim-diminactive'
  "let g:diminactive_use_syntax = 1
  let g:diminactive_enable_focus = 1
Plug 'rrethy/vim-illuminate'
  let g:Illuminate_delay = 100
  augroup illuminate_augroup
    autocmd!
    autocmd VimEnter * hi link illuminatedWord DiffAdd
  augroup END
Plug 'inkarkat/vim-ingo-library'
Plug 'Yggdroot/indentLine'
  let g:indentLine_char = '▏'
Plug 'inkarkat/vim-mark'
  nnoremap <Leader>/ :Mark //<Left>
  let g:mw_no_mappings = 1
  let g:mwDefaultHighlightingPalette = [
  \{ 'ctermbg':'Blue',        'ctermfg':'White', 'guibg':'#80AAFF',     'guifg':'Black' },
  \{ 'ctermbg':'Magenta',     'ctermfg':'White', 'guibg':'#FFAAFF',     'guifg':'Black' },
  \{ 'ctermbg':'Green',       'ctermfg':'White', 'guibg':'#ACFFA1',     'guifg':'Black' },
  \{ 'ctermbg':'Yellow',      'ctermfg':'Black', 'guibg':'#FFE8A1',     'guifg':'Black' },
  \{ 'ctermbg':'Cyan',        'ctermfg':'Black', 'guibg':'#A1FEFF',     'guifg':'Black' },
  \{ 'ctermbg':'Red',         'ctermfg':'Black', 'guibg':'#FFAAAA',     'guifg':'Black' },
  \{ 'ctermbg':'DarkBlue',    'ctermfg':'White', 'guibg':'DarkBlue',    'guifg':'White' },
  \{ 'ctermbg':'DarkMagenta', 'ctermfg':'White', 'guibg':'DarkMagenta', 'guifg':'White' },
  \{ 'ctermbg':'DarkGreen',   'ctermfg':'White', 'guibg':'DarkGreen',   'guifg':'White' },
  \{ 'ctermbg':'DarkYellow',  'ctermfg':'White', 'guibg':'DarkYellow',  'guifg':'Black' },
  \{ 'ctermbg':'DarkCyan',    'ctermfg':'White', 'guibg':'DarkCyan',    'guifg':'White' },
  \{ 'ctermbg':'DarkRed',     'ctermfg':'White', 'guibg':'DarkRed',     'guifg':'White' },
  \{ 'ctermbg':'White',       'ctermfg':'Black', 'guibg':'#E3E3D2',     'guifg':'Black' },
  \{ 'ctermbg':'LightGray',   'ctermfg':'Black', 'guibg':'#D3D3C3',     'guifg':'Black' },
  \{ 'ctermbg':'Gray',        'ctermfg':'White', 'guibg':'#A3A396',     'guifg':'Black' },
  \{ 'ctermbg':'Red',         'ctermfg':'White', 'guibg':'#AA0000',     'guifg':'White' },
  \]
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'irrationalistic/vim-tasks'
Plug 'junegunn/vim-easy-align'          " easy align
Plug 'luochen1990/rainbow'
Plug 'mbbill/undotree'
Plug 'nanotech/jellybeans.vim'
  let g:jellybeans_background_color_256='NONE'
Plug 'nathanaelkane/vim-indent-guides'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'psliwka/vim-smoothie'
  let g:smoothie_update_interval = 16
  let g:smoothie_base_speed = 16
Plug 'sheerun/vim-polyglot'
  let g:polyglot_disabled = ['latex']
Plug 'terryma/vim-multiple-cursors'
Plug 'thinca/vim-logcat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
  let g:airline#extensions#tabline#enabled=1
  let g:airline#extensions#syntastic#enabled=1
  let g:airline#extensions#tabline#buffer_nr_show=1
  let g:airline_theme='dark'
  let g:airline_powerline_fonts=1
  if !exists('g:airline_symbols')
      let g:airline_symbols = {}
  endif
  " unicode symbols
  "let g:airline_left_sep = '»'
  "let g:airline_left_sep = '▶'
  "let g:airline_right_sep = '«'
  "let g:airline_right_sep = '◀'
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
  "call airline#parts#define_function('ALE', 'ALEGetStatusLine')
  "call airline#parts#define_condition('ALE', 'exists("*ALEGetStatusLine")')
  "let g:airline_section_error = airline#section#create_right(['ALE'])
Plug 'mbbill/undotree'
  nnoremap <leader>u :UndotreeToggle<cr>
  let g:undotree_WindowLayout = 2
  let g:undotree_SetFocusWhenToggle = 1
Plug 'vim-scripts/advancedsorters'
Plug 'vimwiki/vimwiki'
Plug 'w0rp/ale'
if has('nvim')
    Plug 'donRaphaco/neotex', { 'for': 'tex' }
    Plug 'norcalli/nvim-colorizer.lua'
else
    Plug 'lervag/vimtex'
    Plug 'tpope/vim-sensible'
endif
call plug#end()

autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

"""""""
" GUI "
"""""""
" Colors
if has('nvim') | set termguicolors | endif
" transparent colors
let g:jellybeans_overrides = {
\    'background': { 'ctermbg': 'none', '256ctermbg': 'none' },
\}
if has('termguicolors') && &termguicolors
    let g:jellybeans_overrides['background']['guibg'] = 'none'
endif
colorscheme jellybeans
if has('nvim')
    lua require 'colorizer'.setup()
endif
""""""""""""
" Settings "
""""""""""""
if !has('nvim')
" vim defaults (nvim already has these by default)
    syntax enable
    set showcmd
    set smarttab
    set hlsearch
    " centralized directory for backup/swap files
    set backupdir=~/.vim/backup//
    set directory=~/.vim/swap//
endif
if has("persistent_undo")
  set undodir=~/.vim/undo//
  set undofile
endif
set hidden
set list listchars=tab:>\ ,trail:·,nbsp:+
set linebreak
set visualbell
set updatetime=100
set ignorecase smartcase
set et ts=2 sw=2
set number numberwidth=2
set wildignorecase " case insensitive tab completion
" vertical help window
autocmd FileType help wincmd L
" highlight TODO for every filetype
augroup HighlightTODO
  autocmd!
  autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', 'todo\|fixme\|hack', -1)
augroup END
" Jump to left-off line on open
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
      \| exe "normal! g`\"" | endif
let g:python3_host_prog='/usr/bin/python3.7'

"""""""""""""""
" Keybindings "
"""""""""""""""
" essentials
map <space> <leader>
nnoremap j gj
nnoremap k gk
nnoremap Q @@
inoremap jk <esc>
" verymagic search by default
nnoremap / /\v
" Save as sudo when vim is not root
cnoremap w!! w !sudo tee > /dev/null %
" splits navigation ctrl+direction
nnoremap <c-h> <c-w><c-h>
nnoremap <c-l> <c-w><c-l>
nnoremap <c-j> <c-w><c-j>
nnoremap <c-k> <c-w><c-k>
" Insert mode completion
"imap <tab>k <plug>(fzf-complete-word)
"imap <tab>f <plug>(fzf-complete-path)
"imap <tab>j <plug>(fzf-complete-file-ag)
"imap <tab>l <plug>(fzf-complete-line)
nnoremap ? :Lines<Enter>
nnoremap :b<Space> :Buf<Enter>
nnoremap :E<Space> :Files<Enter>
" Add selected word to dictionary
nnoremap <leader>s 1z=
nnoremap <leader>ya :%y+
xmap <Enter> <Plug>(EasyAlign)
" neovim terminal escape
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
    tnoremap jk <C-\><C-n>
endif
let g:netrw_liststyle=3 " tree style listing
set splitbelow splitright
set lazyredraw          " speed up macros
set wildignorecase      " case insensitive tab completion
" Ctrl j+k for completion, Ctrl l for digraphs
inoremap <c-j> <c-n>
inoremap <c-k> <c-p>
inoremap <c-l> <c-k>
" enable spellcheck+autosave for notes
autocmd BufRead,BufNewFile notes setlocal spell spelllang=en_us spellcapcheck='' | AutoSaveToggle
" latex
let g:neotex_enabled = 2
let g:neotex_latexdiff = 1
let g:tex_flavor = 'latex'
" i can't input backticks lol
autocmd FileType tex inoremap " ``
autocmd FileType tex setlocal spell spellcapcheck=''
autocmd FileType SIGKILL inoremap I i
autocmd Filetype gitcommit setlocal spell textwidth=64









