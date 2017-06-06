" _VIMPLUG
" _SETTINGS
" __SYNTAX
" __VIM_SPECIFIC
" __NVIM_SPECIFIC
" __OTHER
" __FILE_SPECIFIC
" _PLUGIN
" __AIRLINE
" __ALE
" __AUTOSAVE
" __FZF
" __SMOOTH_SCROLL
" __SYNTASTIC
" __TASKS
" __ULTISNIPS
" __UNDOTREE
" __VIMWIKI
" _KEYBINDINGS
" _PLUGINKEYBINDINGS


"_VIMPLUG
" Plugin 'gmarik/Vundle.vim'
call plug#begin('~/.vim/plugins')
Plug '907th/vim-auto-save'
Plug 'beloglazov/vim-online-thesaurus'
Plug 'ervandew/supertab'
Plug 'honza/vim-snippets'
Plug 'irrationalistic/vim-tasks'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'                     " fuzzy finder
Plug 'junegunn/vim-easy-align'          " easy align
Plug 'lervag/vimtex'
Plug 'mbbill/undotree'
Plug 'nanotech/jellybeans.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'octol/vim-cpp-enhanced-highlight' " cpp syntax highlighting
Plug 'sheerun/vim-polyglot'
Plug 'SirVer/ultisnips'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'w0rp/ale'
Plug 'yuttie/comfortable-motion.vim'
Plug 'vimwiki/vimwiki'
if !has('nvim')
    Plug 'tpope/vim-sensible'
elseif has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
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
"__NVIM_SPECIFIC
" nothing here yet!
"__OTHER
" colorscheme with transparant backgrount
colorscheme jellybeans
hi NonText ctermbg=NONE
hi Normal ctermbg=NONE
" Mark over 80 char lines
highlight ColorColumn ctermbg=darkgrey
" set colorcolumn=81
autocmd FileType python call matchadd('ColorColumn','\%81v',100)
autocmd FileType python set textwidth=80
" Indent settings
" if i ever want to switch to disgusting tabs:
" set ts=4 sw=4 sts=0 noet
set ts=4 sw=4 sts=4 et
set linebreak
set list listchars=tab:>\ ,trail:·,nbsp:+
set visualbell
set number relativenumber numberwidth=2
set ignorecase smartcase
set splitbelow splitright
set hidden
" highlight TODO for every filetype
augroup HiglightTODO
    autocmd!
    autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', 'TODO\|FIXME\|HACK\|DONE', -1)
augroup END
"__FILE_SPECIFIC
" spellcheck for notes
autocmd BufRead,BufNewFile notes setlocal spell spelllang=en_us spellcapcheck=''
autocmd FileType tex inoremap " ``
autocmd FileType tex setlocal spell spellcapcheck=''
autocmd FileType SIGKILL inoremap E ▘
autocmd FileType SIGKILL inoremap O ⊙
autocmd FileType SIGKILL inoremap I i

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

"__DEOPLETE
if has('nvim')
    let g:deoplete#enable_at_startup = 1
endif

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

"__POLYGLOT
let g:polyglot_disabled = ['latex']


"__SMOOTH_SCROLL
let g:comfortable_motion_friction = 100.0
let g:comfortable_motion_air_drag = 2.0

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

"__VIMWIKI
let wiki = [{}]
if hostname() == 'SHODAN'
    " laptop
    let wiki[0].path = '~/Dropbox/vimwiki'
elseif hostname() == 'VISION'
    " desktop
    let wiki[0].path = '/mnt/Stuff/Dropbox/vimwiki'
endif
let wiki[0].nested_syntaxes = {'python': 'python', 'c++': 'cpp', 'java': 'java'}
let g:vimwiki_list = wiki

"_KEYBINDINGS
" essential
nmap <space> <leader>
nnoremap j gj
nnoremap k gk
inoremap jk <esc>
" Save as sudo when vim is not root
cmap w!! w !sudo tee > /dev/null %
" multiple cursors
let g:multi_cursor_insert_maps={'j':1}
" split navigation ctrl+direction
nnoremap <c-j> <c-w><c-j>
nnoremap <c-h> <c-w><c-h>
nnoremap <c-l> <c-w><c-l>
nnoremap <c-k> <c-w><c-k>
" FZF searching
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
" Insert mode completion
"imap <tab>k <plug>(fzf-complete-word)
"imap <tab>f <plug>(fzf-complete-path)
"imap <tab>j <plug>(fzf-complete-file-ag)
"imap <tab>l <plug>(fzf-complete-line)
nnoremap ? :Lines<Enter>
nnoremap <leader>b :Buffers<Enter>
" Add selected word to dictionary
nmap <leader>s 1z=
" use gundo
nnoremap <leader>u :UndotreeToggle<CR>
" use easyalign
vmap <Enter> <Plug>(EasyAlign)
"nmap <Leader>a <Plug>(EasyAlign)
" neovim terminal escape
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
    tnoremap jk <C-\><C-n>
endif
