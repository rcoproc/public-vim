set nocompatible                " be iMproved, required
filetype off                    " required
set nu!                         " Show line numbers
set autoread
set tabpagemax=15               " Only show 15 tabs
set guioptions-=T               " Hide ToolBar
set guioptions-=L               " Hide ToolBar
set backspace=indent,eol,start  " Allow backspace in insert mode
" set history=1000                "Store lots of :cmdline history
set showcmd                     " Show incomplete cmds down the bottom
set showmode                    " Show current mode down the bottom
set gcr=a:blinkon0              " Disable cursor blink
set visualbell                  " No sounds
set mouse=a                     " Disable visual select with mouse
 
" Use clipboard as default register
if system('uname -s') == "Darwin\n"
  set clipboard=unnamed "OSX
else
  set clipboard=unnamedplus "Linux
endif

set undofile                    " Maintain undo history between sessions
set colorcolumn=80              " Setup a line length in vim

set noswapfile
" ================ Indentation ======================

set ruler

highlight clear LineNr          " Current line number row will h
" set showmatch                   " Show matching brackets/parenthesis

set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current

" Auto indent pasted text
" nnoremap p p=`]<C-o>
" nnoremap P P=`]<C-o>

syntax enable
filetype plugin on
filetype indent on

set backspace=indent,eol,start  " backspace for dummys
set linespace=0                 " No extra spaces between rows
set foldenable                  " auto fold code
set gdefault                    " the /g flag on :s substitutions by default
set list
set listchars=tab:>.,trail:.,extends:\#,nbsp:. " Highlightproblematic whitespace
map <leader>ss :setlocal spell!<cr>
" Display tabs and trailing spaces visually
" set list listchars=tab:\ \ ,trail:¬∑

" Close all buffers
map <leader>bc :1..1000 bd!<cr>

let g:scratch_persistence_file="~/anotacoes_rapidas.txt"

" Close all except current
" command BufOnly execute '%bdelete|edit #|normal `"'

" Rais Refactoring Plugin(refactor-rails.vim)
vnoremap <leader>eM  :ExtractMethod<cr>
noremap  <leader>iF  :IndentFile<cr>
noremap  <leader>mF  :MoveCurrentFile<cr>
noremap  <leader>cF  :CopyCurrentFile<cr>
noremap  <leader>rC  :RenameController<cr>

" these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

"Insert the current date and time (useful for timestamps):
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>
"type xdate o insert mode

" Stupid shift key fixes
"cmap W w
cmap WQ wq
cmap wQ wq
"cmap Q q
cmap Tabe tabe
cmap mru MRU

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" ================ Folds ============================

set foldmethod=syntax   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" Space to toggle folds
nnoremap <Space> za
vnoremap <Space> za

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" coc.nvim
" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
" set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
"if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  "inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
"else
  "imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"endif


" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
" nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" grep word under cursor
command! -nargs=+ -complete=custom,s:GrepArgs Rg exe 'CocList grep '.<q-args>

function! s:GrepArgs(...)
  let list = ['-S', '-smartcase', '-i', '-ignorecase', '-w', '-word',
        \ '-e', '-regex', '-u', '-skip-vcs-ignores', '-t', '-extension']
  return join(list, "\n")
endfunction

" Keymapping for grep word under cursor with interactive mode
noremap ;f :exe 'CocList -I -N --input='.expand('<cword>').' grep'<CR>
noremap ;s :exe 'CocSearch '.expand('<cword>').''<CR>


" Mappings using CocList
"
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>



" CocSnippets
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

let g:coc_global_extensions = [
      \ 'coc-solargraph',
      \ 'coc-tsserver',
      \ 'coc-eslint',
      \ 'coc-prettier',
      \ 'coc-json',
      \ ]

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" ================ Completion =======================
set wildmode=list:longest,full
set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=*public*
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.jpeg,*.gif,*.cache
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " Linux/MacOSX
"
" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Search =======================
set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

" GOLang Configs
let g:go_version_warning = 0
let g:go_fmt_fail_silently = 1
let g:go_highlight_types = 1
let g:go_fmt_command = "goimports"
let g:go_highlight_functions_calls = 1
let g:go_highlight_operators = 1
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_fmt_autosave = 0
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_metalinter_deadline = "5s"
let g:go_auto_type_info = 1
let g:github_user ="xpto"

" deoplete-go settings
let g:deoplete#sources#go#gocode_binary = '/home/ricardo/RCO_GO/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#cgo = 0
let g:deoplete#sources#go#source_importer = 1
let g:deoplete#sources#go#unimported_packages = 1

" Ternjs config
" https://github.com/carlitux/deoplete-ternjs
let g:deoplete#sources#ternjs#tern_bin = '/home/ricardo/.nvm/versions/node/v8.16.0/bin/tern'
let g:deoplete#sources#ternjs#timeout = 1

" Whether to use a case-insensitive compare between the current word and 
" potential completions. Default 0
let g:deoplete#sources#ternjs#case_insensitive = 1

" Determines whether the result set will be sorted. Default: 1
let g:deoplete#sources#ternjs#sort = 0

" Whether to include the distance (in scopes for variables, in prototypes for 
" properties) between the completions and the origin position in the result 
" data. Default: 0
let g:deoplete#sources#ternjs#depths = 1

"Add extra filetypes
let g:deoplete#sources#ternjs#filetypes = [
      \ 'jsx',
      \ 'javascript.jsx',
      \ 'vue',
      \ '...'
      \ ]

" Use tern_for_vim.
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]

set updatetime=100

" Path to python interpreter for neovim
let g:python3_host_prog = expand('/usr/bin/python3')
let g:python_host_prog = expand('/usr/bin/python2')
" Skip the check of neovim module
let g:python3_host_skip_check = 1

"silent! let g:plugs['deoplete.nvim'].commit = '08582f7'

let g:translator_target_lang='en'
let g:translator_source_lang='pt'
let g:translator_history_enable=v:true
let g:translator_default_engines=['bing','google']
let g:translator_window_max_width=2.0
let g:translator_window_max_height=20.0

""" Configuration example
" Echo translation in the cmdline
nmap <silent> tt <Plug>Translate
vmap <silent> tt <Plug>TranslateV
" Display translation in a window
nmap <silent> tw <Plug>TranslateW
vmap <silent> tw <Plug>TranslateWV
" Replace the text with translation
nmap <silent> <Leader>r <Plug>TranslateR
vmap <silent> <Leader>r <Plug>TranslateRV
" Translate the text in clipboard
nmap <silent> tx <Plug>TranslateX

set autoindent
set expandtab
set tabstop=2
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2

set path+=lib/**,spec/**
set path+=**



"set notagrelative
"set tags+=/ssd_m2/Documents/RCO_ELIXIR/phoenix_live_view_example,tags;
"set tags+=.tags,tags;
set tags+=tags,tags;
"set tags+=./tags,tags;$HOME

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

set backupdir=~/.temp                        " dont pollute local directory with swap file, backup files etc
set dir=~/.temp
set undodir=~/.temp

" source $VIMRUNTIME/mswin.vim

behave xterm                   "ctrl+c ctrl+v like windows=mswin

" set the runtime path to include Vundle and initialize
" set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()
call plug#begin('~/.vim/plugged')
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
" Plug 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.H" Plugin 'ascenator/L9', {'name': 'newL9'}

"Plugin 'skwp/vim-colors-solarized'
" Plugin 'ayu-theme/ayu-vimH" 
" Plugin 'zandrmartin/vim-distill'
Plug 'voldikss/vim-translator'

"Plug 'ayu-theme/ayu-vim'

Plug 'dart-lang/dart-vim-plugin'

Plug 'flazz/vim-colorschemes'

Plug 'sandeepravi/refactor-rails.vim'

Plug 'yegappan/mru'

"Plugin 'wincent/terminus'
Plug 'mbbill/undotree'

"Plugin 'othree/html5.vim'

Plug 'easymotion/vim-easymotion'

Plug 'alvan/vim-closetag'

Plug 'majutsushi/tagbar'

Plug 'vim-airline/vim-airline'

Plug 'vim-airline/vim-airline-themes'

" Ctrl+P , ctrl+z to select, ctrl+o to to open, ctrl+f, ctrl+b to cycle
" between modes
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'

"Plug 'slim-template/vim-slim.git'

Plug 'scrooloose/nerdtree'

"Anotações Rapidas
Plug 'mtth/scratch.vim'

Plug 'Shougo/unite.vim'

" Powerful file explorer implemented by Vim script
Plug 'Shougo/vimproc.vim'
Plug 'Shougo/vimfiler'
Plug 'Shougo/vimshell.vim'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}
  Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }

  Plug 'Shougo/neco-vim'
  Plug 'neoclide/coc-neco'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  "Plugin 'wokalski/autocomplete-flow'
  "deoplete
  let g:deoplete#enable_at_startup = 1
endif

Plug 'janko/vim-test'

Plug 'Townk/vim-autoclose'

"Plugin 'godlygeek/tabular'

Plug 'scrooloose/nerdcommenter' 

Plug 'tpope/vim-fugitive'

" wraper to fugitive
" Plug 'tommcdo/vim-fubitive'

" A git commit browser. command: :GV!
Plug 'junegunn/gv.vim'

" Silver Search
Plug 'rking/ag.vim'

"Plugin 'craigemery/vim-autotag'

Plug 'nathanaelkane/vim-indent-guides'

Plug 'tpope/vim-git'

Plug 'tpope/vim-rails'

Plug 'tpope/vim-surround'

Plug 'kchmck/vim-coffee-script' 

"Plug 'sjl/gundo.vim'

Plug 'ap/vim-css-color'

Plug 'vim-scripts/loremipsum'

Plug 'terryma/vim-multiple-cursors'

"Plugin 'vim-scripts/ZoomWin'

" This plugin map gag to do Ag search.
" Plug 'Chun-Yang/vim-action-ag'

" Common Libraries
Plug 'vim-scripts/ingo-library'
"Plugin 'writebackup'
"Plugin 'writebackupVersionControl'
" Vim bookmark plugin. command: mm, mi, ma, mc
Plug 'mattesgroeger/vim-bookmarks'

Plug 'airblade/vim-gitgutter'

" Goyo Focus
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" Check syntax in Vim asynchronously and fix files, with Language Server Protocol (LSP) support
Plug 'dense-analysis/ale'

"Plugin 'vim-tmux-navigator'

"Plugin 'Valloric/YouCompleteMe'

Plug 'bonsaiben/bootstrap-snippets'

""Plugin 'slashmili/alchemist.vim'

"Plugin 'vim-scripts/UltiSnips'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
"" Plugin 'fholgado/minibufexpl.vim'
""
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'

"Plugin 'shougo/neocomplete.vim'
" Show bookmarks vim diff
Plug 'mhinz/vim-signify'
Plug 'mhinz/vim-startify'
Plug 'jlanzarotta/bufexplorer'
Plug 'vim-scripts/taglist.vim'

""Plugin 'zhaocai/GoldenView.Vim'

Plug 'blueyed/vim-diminactive'
Plug 'schickling/vim-bufonly'

Plug 'fatih/vim-go'
Plug 'mattn/vim-gist'
"libraries for web api (used by vim-gist)
Plug 'mattn/webapi-vim'

Plug 'rizzatti/dash.vim'
Plug 't9md/vim-choosewin'

Plug 'leafgarland/typescript-vim'
"Plug 'ryanoasis/vim-devicons'
Plug 'vim-syntastic/syntastic'
" Navigate with c-d / c-u o c-f / c-b
Plug  'yuttie/comfortable-motion.vim' 

" Markdown / Writting
Plug 'reedes/vim-pencil'
Plug 'tpope/vim-markdown'
Plug 'jtratner/vim-flavored-markdown'
"Plug 'LanguageTool'

"" Elixir Support 
Plug 'elixir-editors/vim-elixir'
Plug 'avdgaag/vim-phoenix'
" Plug 'mmorearty/elixir-ctags'
Plug 'mattreduce/vim-mix'
Plug 'BjRo/vim-extest'
Plug 'frost/vim-eh-docs'
Plug 'tpope/vim-endwise'
Plug 'jadercorrea/elixir_generator.vim'
Plug 'slashmili/alchemist.vim'
Plug 'airblade/vim-localorie'

" Use release branch (Recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-ruby/vim-ruby' " For Facts, Ruby functions, and custom providers

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" (Optional) Multi-entry selection UI.
Plug 'junegunn/fzf'

" OSX stupid backspace fix
set backspace=indent,eol,start

" All of your Plugins must be added before the following line
call plug#end()            " required
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
"

" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ 'python': ['/usr/local/bin/pyls'],
    \ 'ruby': ['~/.rvm/gems/ruby-2.6.5/bin/solargraph', 'stdio'],
    \ 'elixir': ['~/.config/elixir-ls/rel/language_server.sh'],
    \ }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" Configura√ß√µes solarized
syntax enable
set background=dark
" let ayucolor = "dark"

set t_Co=256
set termguicolors
"colorscheme  ayu     " jellybeans ou olive, ou hotspot
colorscheme  monokai-phoenix

" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

"colorscheme luna       " dracula
"colorscheme solarized  " ayu
"solarized, kolor
let g:solarized_menu=1

"let g:airline_theme='wombat'
"let g:airline_theme='wombat'

"set lines=90

"Configura√ß√µes NERDTREE
"
let NERDTreeShowBookmarks=0
let g:NERDTreeWinPos = "right"
let g:NERDTreeWinSize=45
let NERDTreeQuitOnOpen = 1
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1
let g:nerdtree_tabs_open_on_gui_startup=0

let mapleader = ","
nmap <leader>nf :NERDTreeFind<cr>
nmap <leader>ne :NERDTreeToggle<cr>
nmap <C-X> :NERDTreeClose<cr>

" map RUBY RUN like emacs
" truby is a fast ruby
" map <leader>r :!ruby %<cr>
" map <leader>t :!/Users/Ricardo/Documents/RCO_SOFTWARES/GralVm/graalvm-1.0.0-rc1/Contents/Home/bin/ruby %<cr>

"Configura√ß√µes VimFiler
nmap <leader>vf :VimFiler -buffer-name=explorer -toggle -find -winwidth=50 -no-quit<cr>
" nmap <buffer> d <Plug>(vimfiler_mark_current_line)<Plug>(vimfiler_delete_file)
" nmap <buffer> c <Plug>(vimfiler_mark_current_line)<Plug>(vimfiler_copy_file)
"
" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <C-A> :ZoomToggle<CR>

" Goyo Settings
let g:goyo_width = 150
let g:goyo_height= 40

function! s:goyo_enter()
  set noshowmode
  set noshowcmd
  set scrolloff=999
  set nocursorline
  Limelight
endfunction

function! s:goyo_leave()
  set showmode
  set showcmd
  set scrolloff=5
  set cursorline
  Limelight!
endfunction
" Get current Path/FileName into clipboard
nmap <silent> <leader>cp :let @*=expand("%:p")<CR>    

" Get current FileName only
  nmap <silent> <leader>cf :let @+=expand("%:t:r")<CR>

" filenames like *.xml, *.html, *.xhtml, ...
let g:closetag_filenames = "*.gohtml,*.xml,*.html,*.xhtml,*.phtml,*.erb,*.eex"

""""""" custom commands 
"clear highlights for a search
nnoremap <silent> <leader><space> :noh<CR>

" neocomplete like
set completeopt+=noinsert
" deoplete.nvim recommend
set completeopt+=noselect

" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_fuzzy_completion = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

"let g:neocomplete_enable_camel_case_completion = 0
let g:neocomplete#enable_auto_delimiter = 1
let g:neocomplete#max_list = 10
let g:neocomplete#force_overwrite_completefunc = 1
let g:neocomplete#enable_auto_select = 1
"let g:acp_behaviorRubyOmniMethodLength = -1

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown,eruby setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

autocmd FileType ruby setlocal tabstop=2|set shiftwidth=2|set expandtab|set omnifunc=rubycomplete#Complete
autocmd FileType go setlocal tabstop=2|set shiftwidth=2|set expandtab 
autocmd FileType java setlocal tabstop=2|set shiftwidth=2|set expandtab
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1 
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

" Called :once right before you start selecting multiple cursors
function! Multiple_cursors_before()
  if exists(':NeoCompleteLock')==2
    exe 'NeoCompleteLock'
  endif
endfunction

" Called once only when the multiple selection is canceled (default <Esc>)
function! Multiple_cursors_after()
  if exists(':NeoCompleteUnlock')==2
    exe 'NeoCompleteUnlock'
  endif
endfunction


set selection=inclusive

" Map yank and paste to clipboard(Y and P to CTRL-C and CTRL-V)
noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p

"Tabularize Keys
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
endif

" Ativa linhas coloridas nos marcadores;
let g:bookmark_highlight_lines = 1

"set guifont=Roboto\ Mono\ Medium\ for\ Powerline:h16
set guifont=Source\ Code\ Pro\ for\ Powerline:h14
let g:Powerline_symbols = 'fancy'
set ts=2 sw=2 et
hi CursorColum cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
hi Visual guifg=#000000 guibg=#FFFFFF gui=none
nnoremap <Leader>C :set cursorline! cursorcolumn!<CR>

" set the cursor shape
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"

if &term =~ '^xterm\\|rxvt'
  " solid underscore
  let &t_SI .= "\<Esc>[5 q"
  " solid block
  let &t_EI .= "\<Esc>[2 q"
  " 1 or 0 -> blinking block
  " 3 -> blinking underscore
  " Recent versions of xterm (282 or above) also support
  " 5 -> blinking vertical bar
  " 6 -> solid vertical bar
endif

"let g:airline_theme= 'durant' " 'tomorrow'
let g:airline_theme= 'luna' " 'tomorrow'
"let g:airline_theme='bubblegum'
let g:airline_inactive_collapse=1
let g:airline#extensions#branch#displayed_head_limit = 15
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#branch#empty_message = ''
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
" let g:airline#extensions#tabline#fnamemod =':t:r'
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#hunks#non_zero_only = 0
" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1
" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1
" Show only filename in section c 
"
let g:airline_section_c = '%F'
"let g:airline_section_c = '%t'
" Hidden file type in Section X ( ruby, javascript , etc )
" let g:airline_section_x = ''
" Hidden file type in Section Y ( utf-8 )
let g:airline_section_x = ''
let g:airline_section_y = ''

"AirlineTheme papercolor(azul) ou molokai(laranjado)
"let AirlineToggleWhitespace
"
let g:airline#extensions#tabline#buffer_idx_mode = 1

nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab

"nmap <leader>cl :put =expand('%:p')<cr>

function! ShowRoutes()
  " Requires 'scratch' plugin
  :topleft 100 :split __Routes__
  " Make sure Vim doesn't write __Routes__ as a file
  :set buftype=nofile
  " Delete everything
  :normal 1GdG
  " Put routes output in buffer
  :0r! rake -s routes
  " Size window to number of lines (1 plus rake output length)
  :exec ":normal " . line("$") . "_ "
  " Move cursor to bottom
  :normal 1GG
  " Delete empty trailing line
  :normal dd
  :normal 1gg
endfunction

map <leader>gR :call ShowRoutes()<cr>

" - invoke with '-'
nmap - <Plug>(choosewin)

" F2 Plugin List
" map <F2> :PluginList<cr>

" F3 Open MRU Window
map <F3> :MRU<cr>

" F4 List open Tabs
map <F4> :tabs<cr>

" Mapeia o F5 para o Gundo
" nnoremap <F5> :GundoToggle<CR>

" F6 List open Buffers
map <F6> :BufExplorer<CR>

" F7 TagbarToggle
map <F7> :TagbarToggle<CR>

" F8 Open VIMRC
map <F8> :edit ~/.config/nvim/init.vim<CR>

" Configuration MRU(Most recent files)
" let MRU_Filename_Format={'formatter':'v:val', 'parser':'.*'}
let MRU_Window_Height = 20
let MRU_Use_Current_Window = 1
let MRU_Max_Menu_Entries = 20

" Configuration for TagList
let Tlist_Sort_Type = "name"

let g:syntastic_html_tidy_ignore_errors=["<ion-", "discarding unexpected </ion-", " proprietary attribute \"ng-"]

"let g:UltiSnipsEnableSnipMate
"let g:snipMate.scope_aliases['ruby'] = 'ruby,ruby-rails,ruby-1.9'

"let b:UltiSnipsSnippetDirectories=["/Users/Ricardo/.yadr/vim/bundle/vim-snippets/snippets"]
"let g:UltiSnipsSnippetDirectories=["/home/ricardo/.vim/plugged/vim-snippets/snippets"]

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

let g:ycm_key_list_select_completion = ['<C-r>']
let g:ycm_key_invoke_completion = '<C-l'

" Plugin key-mappings NEOSNIPPET.
let g:neosnippet#enable_completed_snippet = 1
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_:or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" Configuration for Mate SNIPETS
"let g:snipMate = {}
"let g:snipMate.scope_aliases = {}
"let g:snipMate.scope_aliases['ruby'] = 'ruby,rails,ruby-rails,Rails'

" nmap Configuration for Gi:tGutter
nmap <Leader>hs <Plug>GitGutterStageHunk
nmap <Leader>hu <Plug>GitGutterUndoHunk
nmap <Leader>hp <Plug>GitGutterPreviewHunk


" nmap Configuration for fugitive
nmap <leader>gb :Gblame<CR>
nmap <leader>gs :Gstatus<CR>
nmap <leader>gc :Gcommit<CR>
nmap <leader>gp :Git push<CR>
nmap <leader>gl :Glog<CR>
nmap <leader>gd :Gvdiff<CR>

" Set local Working Directory
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " Linux/MacOSX

let g:ctrlp_match_window = 'min:4,max:25'

" Map para CtrlPFunky
nnoremap <Leader>fu :CtrlPFunky<Cr>
" narrow the list down with a word under cursor
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>

let g:multi_cursor_use_default_mapping=1

"
" Default mapping:
"let g:multi_cursor_next_key='<C-0>'
"let g:multi_cursor_prev_key='<C-9>'
"let g:multi_cursor_skip_key='<C-q>'
"let g:multi_cursor_quit_key='<C-1>'

highlight BookmarkSign ctermbg=NONE ctermfg=160
highlight BookmarkLine ctermbg=194 ctermfg=NONE
"let g:bookmark_sign = '‚ô•'
let g:bookmark_highlight_lines = 1

" Map start key separately from next key
"let g:multi_cursor_start_key='<C-2>'

"let g:goldenview__enable_default_mapping = 0

" 1. split to tiled windows
"nmap <silent> <C-L>  <Plug>GoldenViewSplit
"nmap <silent> <S-F7> <Plug>GoldenViewSwitchToggle

" 2. quickly switch current window with the main pane
" and toggle back
"nmap <silent> <C-L>   <Plug>GoldenViewSwitchMain
"nmap <silent> <S-F7> <Plug>GoldenViewSwitchToggle

" 3. jump to next and previous window
"nmap <silent> <S-N>  <Plug>GoldenViewNext
"nmap <silent> <S-P>  <Plug>GoldenViewPrevious

let g:startify_skiplist = [
           \ '\.log',
           \ '\.bak'
           \ ]

" let g:startify_change_to_dir = 1
let g:ascii = [
                \ '-----------------------------------------------------------------------------------------------------------------------',
                \ ':[<ctrl+w r> rotate window to right R(to left), [<ctrl+w J>] swap Window down, [ctrl+w H] swap Window left, gc4j Comment/Uncomment, gx Open URI under cursor, :!open URI',
                \ ':SPLIT: [ctrl+w t] e [ctrl+w K] (Vertical to Horizontal), [ctrl+w t] e [ctrl+w H] (Horizontal to Vertically)',
                \ ':MRU , :CtrlP , :TlistOpen,  :Startify , :AirlineToggle , :AirlineTheme lucius , :PluginList , :PluginInstall ',
                \ ':GStatus , GCommit, :GPush, :GDiff, :Gundo, :Gblame :Ag texto --ruby ',
                \ ':EController payment , :EModel Person , :Elib, :Ejavascript application, :Estylesheet application, :Environment production, :BOpen ',
                \ ':bufdo bd # Close All buffers, :1,10bd Close Buffers 1 to 10, Ctrp <ctrl+b> Switch modes, <ctrl+z> Mark Files, <ctrl+o> Open files ',
                \ '-----------------------------------------------------------------------------------------------------------------------',
                \ ':%s/\s\+$// # Remove trailing spaces, :%s/$/,/g # Acresc. final de linha com , :%s/^/INSERT /g  #Insere come√ßo de linha',
                \ ':%s/\n/, /g # Substitui final de linha por ,  :.,$s/abc/cde/g # A partir da linha atual, :2,14s/abc/cde/g # Subs. das linhas 2 ao 14  gU ou gu (Upper ou Lower Case)',
                \ ':g/^$/d     # Limpa linhas em branco :h pattern e h range # Help de Patterns RegExp e dos Ranges' ,
                \ 'fpv<C-n><C-n>cfirst_name # Exemplo Multiplo-Cursor 1, vip<C-n>i" # Multiplo Cursor(C-n) 2',
                \ '-----------------------------------------------------------------------------------------------------------------------',
                \ 'CTAGS: ctrl+] Jump do definition, ^o ou ^t Jump to back from definition, g] See all definitions, ctrl+W } Preview Definition'
            \ ]


" let g:startify_custom_header  = '[""]'
let g:startify_custom_header = 'map(g:ascii, "\"   \".v:val" )'
"let g:startify_custom_header = 'map(startify#fortune#boxed() + g:ascii, "\"   \".v:val" )'

let g:startify_files_number = 13
let g:startify_custom_footer = [
                                \ "                                     BOOKMARKS: mm BookmarkToggle, mi BookmarkAnnotate <TEXT>, ma BookmarkShowAll, mc BookmarkClear, mx BookmarkClearAll",
                                \ "                                     [,cp] Copy path/filename to clipboard [,cf] Copy only filename to clipboard",
                                \ "   by Ricardo Oliveira. ':Enjoy It'. [,,s] Find character [,cl] Get file Name [,mw] Mark Window [,pw] Change Window [,hu] Undo Hunk [,ig] Indent Guide",
                                \ "   RCO                               [<F2>] Plugin list [<F3>] MRU [<F4>] Tabs [<F5>] Gundo |<F6>| Buffers [<F9:w Explorer[<F10>] TagList [<F11>] vimrc [,ne] NERDTree [<C-X>] Close NERDTree, *insert mode* [<C-o] 80i-<ESC>",
                                \ '                                     [:set paste/paste (disable/enable auto ident), :%s/\ /\,/g # replace space by comma ], :ls # list all buffers, :1b # change atual buffer',
                                \ '                                     -----------------------------------------------------------------------------------------------------------------------',
                            \ ]
let g:startify_change_to_vcs_root = 1


set encoding=UTF-8

" reopening a file:
if has("autocmd")
  " au!
  "au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  "au BufWinLeave *.rb mkview
  "au BufWinEnter *.rb silent loadview
  " Reabre o VIM com o Airline confNgurado corretamente
  " Mais informa√ß√µes em:
  " http://www.ibm.com/developerworks/library/l-vim-script-5/
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
  au BufWinEnter * silent AirlineToggleWhitespace
  au BufWinEnter * silent AirlineToggle
  au BufWinEnter * silent AirlineToggle
  "au BufEnter *.rb silent UltiSnipsAddFiletypes ruby
  "au BufEnter *.rb silent UltiSnipsAddFiletypes rails
  au Filetype html,xml,xsl,erb,eex source ~/.vim/bundle/vim-closetag/plugin/closetag.vim
  au BufNewFile,BufRead *.coffee set filetype=coffee
  au BufRead,BufNewFile *.gohtml set filetype=gohtmltmpl

  autocmd FileType ruby setlocal tabstop=2|set shiftwidth=2|set expandtab|set omnifunc=rubycomplete#Complete
  autocmd FileType go setlocal tabstop=2|set shiftwidth=2|set expandtab 
  autocmd FileType java setlocal tabstop=2|set shiftwidth=2|set expandtab
  autocmd FileType elixir setlocal tabstop=2|set shiftwidth=2|set expandtab
  autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1 
  autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
  autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
end

" Most prefer to automatically switch to the current file directory when
" a new buffer is opened; to prevent this behavior, add the following to
" your .vimrc.before.local file:
"   let g:spf13_no_autochdir = 1
"if !exists('g:spf13_no_autochdir')
"    autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
"    " Always switch to the current file directory
"endif

if has("persistent_undo")
  set undodir="/Users/ricardo/.undodir"
  set undofile
endif

"let g:TerminusCursorShape=1
"let g:TerminusInsertCursorShape=2
"let g:TerminusNormalCursorShape=0
"let g:TerminusReplaceCursorShape=1
"let g:TerminusLoaded=1


