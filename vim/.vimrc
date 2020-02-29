" install vim-plug if not already installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"""""""""""
" Plugins "
"""""""""""

call plug#begin('~/.vim/plugins')
Plug '907th/vim-auto-save'
Plug 'Yggdroot/indentLine'
Plug 'chrisbra/recover.vim'
Plug 'mhinz/vim-signify'
Plug 'derekwyatt/vim-fswitch'
Plug 'camspiers/lens.vim'
Plug 'aserebryakov/vim-todo-lists'
Plug 'beloglazov/vim-online-thesaurus'
Plug 'embear/vim-foldsearch'
Plug 'jaxbot/semantic-highlight.vim'
Plug 'rhysd/vim-clang-format'
autocmd FileType c,cpp,objc map <buffer><Leader>= <Plug>(operator-clang-format)
Plug 'honza/vim-snippets'
Plug 'ericcurtin/CurtineIncSw.vim'
Plug 'inkarkat/vim-ingo-library'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
let g:mkdp_auto_start = 1
Plug 'inkarkat/vim-mark'
Plug 'irrationalistic/vim-tasks'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'                 " fuzzy finder
Plug 'junegunn/vim-easy-align'          " easy align
Plug 'kshenoy/vim-signature'            " display marks
Plug 'luochen1990/rainbow'
Plug 'markonm/traces.vim'               " command preview
Plug 'mbbill/undotree'
Plug 'nanotech/jellybeans.vim'
Plug 'nathanaelkane/vim-indent-guides'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'bfrg/vim-cpp-modern' " cpp syntax highlighting
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'psliwka/vim-smoothie'             " smooth scrolling
Plug 'sheerun/vim-polyglot'
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
Plug 'thinca/vim-logcat'                " logcat highlighting
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'vim-airline/vim-airline'
Plug 'vim-scripts/advancedsorters'
Plug 'vimwiki/vimwiki'
"Plug 'w0rp/ale'
if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    " close preview after leaving insert mode
    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
    " Tab completion
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

    Plug 'Shougo/deoplete-clangx'
    Plug 'Shougo/neoinclude.vim'
    Plug 'donRaphaco/neotex', { 'for': 'tex' }
    Plug 'norcalli/nvim-colorizer.lua' " preview colors
else
    Plug 'lervag/vimtex'
    Plug 'tpope/vim-sensible'
endif
call plug#end()

autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

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
    set nobackup
    set nowritebackup
    set directory=~/.vim/swap//
    set undodir=~/.vim/undo//
endif
if has("patch-8.1.0360")
    set diffopt+=internal,algorithm:patience
endif
if has("persistent_undo")
    set undodir=~/.vim/undo//
    set undofile
endif
set updatetime=100
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
nnoremap <c-j> <c-w><c-j>
nnoremap <c-h> <c-w><c-h>
nnoremap <c-l> <c-w><c-l>
nnoremap <c-k> <c-w><c-k>
" FZF searching
" Mapping selecting mappings
nnoremap <leader><tab> <plug>(fzf-maps-n)
xnoremap <leader><tab> <plug>(fzf-maps-x)
onoremap <leader><tab> <plug>(fzf-maps-o)
" Insert mode completion
"imap <tab>k <plug>(fzf-complete-word)
"imap <tab>f <plug>(fzf-complete-path)
"imap <tab>j <plug>(fzf-complete-file-ag)
"imap <tab>l <plug>(fzf-complete-line)
nnoremap ? :Lines<Enter>
nnoremap :b :Buf<Enter>
nnoremap <C-p> :Files<Enter>
" Add selected word to dictionary
nnoremap <leader>s 1z=
nnoremap <leader>ya :%y+
nnoremap <leader>u :UndotreeToggle<CR>
map <A-o> :call CurtineIncSw()<Cr>
xmap <Enter> <Plug>(EasyAlign)
" neovim terminal escape
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
    tnoremap jk <C-\><C-n>
endif
"""COC"""
"inoremap <silent><expr> <TAB>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<TAB>" :
"      \ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"function! s:check_back_space() abort
"  let col = col('.') - 1
"  return !col || getline('.')[col - 1]  =~# '\s'
"endfunction
"inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
"" Use K to show documentation in preview window
"function! s:show_documentation()
"  if (index(['vim','help'], &filetype) >= 0)
"    execute 'h '.expand('<cword>')
"  else
"    call CocAction('doHover')
"  endif
"endfunction
"nnoremap <silent> K :call <SID>show_documentation()<CR>
"autocmd CursorHold * silent call CocActionAsync('highlight')

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
" Marks
let g:mw_no_mappings = 1
let g:mwDefaultHighlightingPalette = [
\{ 'ctermbg':'Blue',        'ctermfg':'Black', 'guibg':'#80AAFF',     'guifg':'Black' },
\{ 'ctermbg':'Magenta',     'ctermfg':'Black', 'guibg':'#FFAAFF',     'guifg':'Black' },
\{ 'ctermbg':'Green',       'ctermfg':'Black', 'guibg':'#ACFFA1',     'guifg':'Black' },
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
" Mark over 80 char lines
highlight ColorColumn ctermbg=darkgrey
nnoremap <Leader>/ :Mark //<Left>
" set colorcolumn=81
" autocmd FileType python call matchadd('ColorColumn','\%81v',100)
"autocmd FileType python set textwidth=80
"autocmd FileType python set colorcolumn=80

"""""""""""""""""
" Functionality "
"""""""""""""""""
let g:netrw_liststyle=3 " tree style listing
set splitbelow splitright
set lazyredraw          " speed up macros
set wildignorecase      " case insensitive tab completion
" Ctrl j+k for completion, Ctrl l for digraphs
inoremap <c-j> <c-n>
inoremap <c-k> <c-p>
inoremap <c-l> <c-k>
" Git gutter signs
let g:signify_sign_change = '~'
highlight SignColumn ctermbg=NONE cterm=NONE guibg=NONE gui=NONE
highlight SignifySignAdd ctermfg=LightGreen guifg=LightGreen
highlight SignifySignDelete ctermfg=LightRed guifg=LightRed
highlight SignifySignChange ctermfg=LightBlue guifg=LightBlue
" Deoplete
let g:deoplete#enable_at_startup = 1
call deoplete#custom#var('clangx', 'clang_binary', '/usr/bin/clang')
call deoplete#custom#var('clangx', 'default_c_options', '')
call deoplete#custom#var('clangx', 'default_cpp_options', '')
" Logcat
"autocmd FileType logcat set notermguicolors
autocmd BufReadPost * if exists("b:current_syntax") && b:current_syntax == "logcat"
autocmd BufReadPost *     syn keyword myTags AudioALSA AudioPatch
autocmd BufReadPost *     syn keyword myKeywords success
autocmd BufReadPost * endif

""""""""""""""
" Formatting "
""""""""""""""
" Indent settings
" set ts=4 sw=4 sts=0 noet "tabs
set tabstop=4 shiftwidth=4 softtabstop=4 et "notabs
set linebreak
set list listchars=tab:>\ ,trail:·,nbsp:+
set visualbell
set number numberwidth=2
set ignorecase smartcase
set hidden
" highlight TODO for every filetype
augroup HiglightTODO
    autocmd!
    autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', 'TODO\|FIXME\|HACK\|DONE', -1)
augroup END
" vertical help window
autocmd FileType help wincmd L
"""""""""""""""""
" File Specific "
"""""""""""""""""
" let default file type be logcat
autocmd BufEnter * if &filetype == "" | setlocal ft=logcat | endif
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

""_PLUGINS
let g:smoothie_update_interval = 16
let g:smoothie_base_speed = 16
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
let g:jellybeans_background_color_256='NONE'
"__ALE
let g:ale_lint_delay = 500

"__AUTOSAVE
let g:auto_save = 0
let g:auto_save_no_updatetime = 1
let g:auto_save_in_insert_mode = 0


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

"__GITGUTTER
let g:gitgutter_highlight_linenrs = 1
let g:gitgutter_grep = 'rg'

"__INDENT
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1

"__POLYGLOT
let g:polyglot_disabled = ['latex']

"__RAINBOW
let g:rainbow_active = 1

"__UNDOTREE
let g:undotree_WindowLayout = 2
let g:undotree_SetFocusWhenToggle = 1

"__CPP HIGHLIGHTING
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl = 1
let g:cpp_experimental_simple_template_hightlight = 1

" _OTHER
" cscope
function! Cscope(option, query)
  let color = '{ x = $1; $1 = ""; z = $3; $3 = ""; printf "\033[34m%s\033[0m:\033[31m%s\033[0m\011\033[37m%s\033[0m\n", x,z,$0; }'
  let opts = {
  \ 'source':  "cscope -dL" . a:option . " " . a:query . " | awk '" . color . "'",
  \ 'options': ['--ansi', '--prompt', '> ',
  \             '--multi', '--bind', 'alt-a:select-all,alt-d:deselect-all',
  \             '--color', 'fg:188,fg+:222,bg+:#3a3a3a,hl+:104'],
  \ 'down': '40%'
  \ }
  function! opts.sink(lines) 
    let data = split(a:lines)
    let file = split(data[0], ":")
    execute 'e ' . '+' . file[1] . ' ' . file[0]
  endfunction
  call fzf#run(opts)
endfunction

" Invoke command. 'g' is for call graph, kinda.
nnoremap <silent> <Leader>g :call Cscope('3', expand('<cword>'))<CR>

