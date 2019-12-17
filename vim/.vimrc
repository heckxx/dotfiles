" install vim-plug if not already installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"_VIMPLUG
call plug#begin('~/.vim/plugins')
Plug '907th/vim-auto-save'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-css-color'
Plug 'aserebryakov/vim-todo-lists'
Plug 'beloglazov/vim-online-thesaurus'
Plug 'embear/vim-foldsearch'
Plug 'honza/vim-snippets'
Plug 'inkarkat/vim-ingo-library'
Plug 'inkarkat/vim-mark'
Plug 'irrationalistic/vim-tasks'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'                 " fuzzy finder
Plug 'junegunn/vim-easy-align'          " easy align
Plug 'kshenoy/vim-signature'            " display marks
Plug 'lervag/vimtex'
Plug 'luochen1990/rainbow'
Plug 'markonm/traces.vim'               " command preview
Plug 'mbbill/undotree'
Plug 'nanotech/jellybeans.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'octol/vim-cpp-enhanced-highlight' " cpp syntax highlighting
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'psliwka/vim-smoothie'
Plug 'sheerun/vim-polyglot'
Plug 'terryma/vim-multiple-cursors'
Plug 'thinca/vim-logcat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-scripts/advancedsorters'
Plug 'vimwiki/vimwiki'
Plug 'w0rp/ale'
if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
    Plug 'tpope/vim-sensible'
endif
call plug#end()

autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

"_SETTINGS
"__VIM_SPECIFIC
" vim defaults (nvim already has these by default)
if !has('nvim')
    syntax enable
    set showcmd
    set smarttab
    set hlsearch
    " centralized directory for backup/swap files
    set backupdir=~/.vim/backup//
    set directory=~/.vim/swap//
endif
let g:netrw_liststyle=3
let g:python3_host_prog='/usr/bin/python3.7'

"__OTHER
" colorscheme with transparant backgrount
colorscheme jellybeans
hi NonText ctermbg=NONE
hi Normal ctermbg=NONE
" Mark over 80 char lines
highlight ColorColumn ctermbg=darkgrey
" set colorcolumn=81
" autocmd FileType python call matchadd('ColorColumn','\%81v',100)
"autocmd FileType python set textwidth=80
"autocmd FileType python set colorcolumn=80
" Indent settings
" set ts=4 sw=4 sts=0 noet "tabs
set tabstop=4 shiftwidth=4 softtabstop=4 et "notabs
set linebreak
set list listchars=tab:>\ ,trail:·,nbsp:+
set visualbell
set number numberwidth=2
set ignorecase smartcase
set splitbelow splitright
set hidden
set wildignorecase "case insensitive tab completion
" highlight TODO for every filetype
augroup HiglightTODO
    autocmd!
    autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', 'TODO\|FIXME\|HACK\|DONE', -1)
augroup END
"__FILE_SPECIFIC
" let default file type be logcat
autocmd BufEnter * if &filetype == "" | setlocal ft=logcat | endif
" spellcheck for notes
autocmd BufRead,BufNewFile notes setlocal spell spelllang=en_us spellcapcheck='' | AutoSaveToggle
" vertical help window
autocmd FileType help wincmd L
" i can't input backticks lol
autocmd FileType tex inoremap " ``
autocmd FileType tex setlocal spell spellcapcheck=''
autocmd FileType SIGKILL inoremap E ▘
autocmd FileType SIGKILL inoremap O ⊙
autocmd FileType SIGKILL inoremap I i
autocmd Filetype gitcommit setlocal spell textwidth=64
" speed up macros
set lazyredraw

"_PLUGIN
let g:mwDefaultHighlightingPalette = 'extended'
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

"__DEOPLETE
let g:deoplete#enable_at_startup = 1

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

"__CPP HIGHLIGHTING
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl = 1
let g:cpp_experimental_simple_template_hightlight = 1

"__MULTIPLESEARCH
let g:MultipleSearchMaxColors = 8
let g:MultipleSearchColorSequence = "red,yellow,blue,green,magenta,cyan,gray,brown"
let g:MultipleSearchTextColorSequence = "white,black,black,black,black,white,white,white"

"_KEYBINDINGS
" essential
map <space> <leader>
nnoremap j gj
nnoremap k gk
nnoremap Q @@
inoremap jk <esc>
" Save as sudo when vim is not root
cnoremap w!! w !sudo tee > /dev/null %
" multiple cursors
let g:multi_cursor_insert_maps={'j':1}
" split navigation ctrl+direction
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
nnoremap <leader>b :Buffers<Enter>
" Add selected word to dictionary
nnoremap <leader>s 1z=
nnoremap <leader>ya :%y+
" use gundo
nnoremap <leader>u :UndotreeToggle<CR>
" use easyalign
xmap <Enter> <Plug>(EasyAlign)
"nmap <Leader>a <Plug>(EasyAlign)
" neovim terminal escape
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
    tnoremap jk <C-\><C-n>
endif
nnoremap :E<Space> :Files<Enter>
nnoremap :b :Buf<Enter>
nnoremap / /\v

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

