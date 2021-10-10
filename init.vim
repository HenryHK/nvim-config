" Plugins enabled using vim-plug
call plug#begin('~/.local/share/nvim/plugged')

" fast commenting
" See https://github.com/scrooloose/nerdcommenter
" gcc to toggle comment
Plug 'scrooloose/nerdcommenter'
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Surround is about change/add surroundings of code
" See https://github.com/tpope/vim-surround
Plug 'git://github.com/tpope/vim-surround.git'
" for repeat -> enhance surround.vim, . to repeat command
Plug 'tpope/vim-repeat'

" fuzzy search everything utilizing fzf
" if fzf is installed via homebrew
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" file tree in current directory
" <ctrl>-n to toggle
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
" devicons
Plug 'ryanoasis/vim-devicons'

" Airline enhancing bottom line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
" https://github.com/junegunn/gv.vim, :GV
Plug 'junegunn/gv.vim'
Plug 'airblade/vim-gitgutter'
Plug 'APZelos/blamer.nvim'

" Tagbar is a Vim plugin that provides an easy way to browse the tags of the current file and get an overview of its structure
" <F9> to toggle
Plug 'majutsushi/tagbar'

" vim go plugin
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Use coc instead of old ycm
" Use release branch
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" rainbow parentheses improved
Plug 'luochen1990/rainbow'
" 0 if you want to enable it later via :RainbowToggle
let g:rainbow_active = 1 

" EasyFold only for Python
Plug 'tmhedberg/SimpylFold'
let g:SimpylFold_docstring_preview = 1

" indentation indication
Plug 'Yggdroot/indentLine'
let g:indentLine_char = '|'

" Vim JavaScript
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'w0rp/ale'

" Vim JSON
Plug 'elzr/vim-json'

" session management
Plug 'tpope/vim-obsession'

" gruv color schema
Plug 'morhetz/gruvbox'

" floatterm, simply the best
Plug 'voldikss/vim-floaterm'

" TreeSitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" wakatime
Plug 'wakatime/vim-wakatime'

" end of plugins settings
call plug#end()

" Beiginning of general configuration

" magic of using vim
set nocompatible

" fundamental settings
" use dracula theme as the color theme
autocmd vimenter * colorscheme gruvbox

" improve neovim performance slightly
set nocursorcolumn
set nocursorline

" set layout format
set scrolljump=5
" control whether highlight current line
:hi CursorLine   cterm=NONE ctermbg=240 ctermfg=white guibg=188 guifg=white

" file encoding
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1

" use space to all tab, set indentation to 4
set tabstop=4
set shiftwidth=4
set expandtab

" turn on line number
set number
" abosolute line number in normal mode
" relative line number in insert mode
autocmd InsertLeave * :set norelativenumber number
autocmd InsertEnter * :set relativenumber

" find as typing
set incsearch
" highlight search terms
set hlsearch
set lazyredraw

" ignore case when searching
set ignorecase
" if search input contains upper case, do not ignore
set smartcase

" toggle file type on
filetype on
" toggle plugin on
filetype plugin on
" toggle plugin indent on
filetype plugin indent on

" enable syntax
" this is to help with devicons load problem
" https://github.com/ryanoasis/vim-devicons/issues/215
if !exists('g:syntax_on')
	syntax enable
endif

" allow to use mouse
set mouse=a
set mousehide

" turn on spell check
set nospell

" smart indentation
set autoindent

" show matched brackets and so on
set showmatch

" fold method
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable

" this is needed for correctly syntax highlight long lines
" for me it's js string literals, found the answer here: https://www.reddit.com/r/vim/comments/7imly7/syntax_highlighting_breaks_on_really_long_lines/
" this could dramatically slow performance, you may need to set this to a
" certain number or just do :syntax off
set synmaxcol=0
syntax sync minlines=256

" set true color, https://github.com/morhetz/gruvbox/wiki/Terminal-specific
set termguicolors

" sepcial indentation for jsx and coffeescript
autocmd FileType javascript.jsx setlocal tabstop=2 shiftwidth=2 noexpandtab
autocmd BufNewFile,BufReadPost *.coffee setl tabstop=2 shiftwidth=2 expandtab foldmethod=manual
" support json comment
autocmd FileType json syntax match Comment +\/\/.\+$+

" basic key mappings and shortcuts
" map leader to <Space>
let mapleader="\<SPACE>"
" doubel press esc to disable highlight in current document
map <esc><esc> :noh<return> 
" change <ESC> to jj
imap jj <ESC>
" use <Leader>+cur to toggle highlight current line
:nnoremap <Leader>cur :set cursorline! cursorcolumn!<CR>
" visual shifting
vnoremap < <gv
vnoremap > >gv
" tab move
nnoremap H gT
nnoremap L gt
" easier split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" easier split vertical resize
nnoremap <S-Up> <C-w>+
nnoremap <S-Down> <C-w>-
nnoremap <S-Right> <C-w>>
nnoremap <S-Left> <C-w><

" clipboard setting
"See https://stackoverflow.com/questions/11489428/how-to-make-vim-paste-from-and-copy-to-systems-clipboard
if has('clipboard')
  if has('unnamedplus') " When possible use + register for copy-paste
    set clipboard=unnamed,unnamedplus
  else                  " On mac and Windows, use * register for copy-paste
    set clipboard=unnamed
  endif
endif

" Vim general settings for coc
" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" abbrevation for command function
function! SetupCommandAbbrs(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

" plugin settings 
" vim-plug
" install plugin using vim-plug
map <leader>pi :PlugInstall<CR>
map <leader>cl :PlugClean<CR>

" tagbar toggle mapping
nmap <F9> :TagbarToggle<CR>

" nerdcomment
" use gcc to quickly toggle comments in normal and visual mode
nnoremap gcc :call nerdcommenter#Comment("n", "Comment")<CR>
vnoremap gcc :call nerdcommenter#Comment("n", "Comment")<CR>

" GitGutter
nmap <right><right> <Plug>(GitGutterNextHunk)
nmap <left><left> <Plug>(GitGutterPrevHunk)
nmap gua <Plug>(GitGutterUndoHunk)
nmap gpr <Plug>(GitGutterPreviewHunk)

" Nerdtree
" open nerdtree automatically when nvim open
" autocmd vimenter * NERDTree
" close vim if the only window left is open is nerd tree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" nerdtree key shortcuts
map <C-n> :NERDTreeToggle<CR>
" NERDTree configurations, this doesn't fully work, additional square brackets
" are added somehow to folders
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
if exists('g:loaded_webdevicons')
  call webdevicons#refresh()
endif

" Go Configuration
autocmd BufWritePre *.go :GoBuild
" this will freeze terminal and slow down save, just run it manually when big changes are made
" and keep location/quickfix list clean
" autocmd BufWritePre *.go :GoMetaLinter
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1
" add json tags automatically, e.g. :GoAddTags json bson
let g:go_addtags_transform = "snakecase"
let g:go_def_mode = 'gopls'
let g:go_info_mode = 'gopls'
" golangci-lint with custom config file
let g:go_metalinter_command='golangci-lint run --print-issued-lines=false --build-tags --exclude-use-default=use'
" F10 for coverage report
au FileType go nmap <F10> :GoCoverageToggle -short<cr>

" TODO: JavaScript Configuration
let g:jsx_ext_required = 0
let g:javascript_plugin_jsdoc = 1
let g:neoformat_enabled_javascript = ['prettier']
" Ale configuration: lint plugin
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
let g:ale_lint_on_enter = 0 " Less distracting when opening a new file
let g:airline#extensions#ale#enabled = 0
let g:ale_fixers = {'javascript': ['eslint']}
let g:ale_fix_on_save = 0
let g:ale_open_list = 0

" TODO: Python Configuration
let g:neoformat_enabled_python = ['autopep8', 'isort']

" Flutter Configuration
let g:dart_style_guide = 2
let dart_html_in_string=v:true

" fzf configuration
" ctrlp files fuzzy search using fzf
nmap <C-p> :Files<CR>
" buffer fuzzy search 
nmap <C-e> :Buffers<CR>
nmap <C-g> :GF?<CR>
" fzf open action
let g:fzf_action = {
  \ 'ctrl-e': 'edit',
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" autocomplete for :Git checkout <branch>
function! s:gitCheckoutRef(ref) 
    execute('Git checkout ' . a:ref)
endfunction

" autocomplete for :Git command
function! s:gitListRefs()
   let l:refs = execute("Git for-each-ref --format='\\%(refname:short)'")
   return split(l:refs,'\r\n*')[1:] "jump past the first line which is the git command
endfunction

" magic to fzf with git
command! -bang Gbranch call fzf#run({ 'source': s:gitListRefs(), 'sink': function('s:gitCheckoutRef'), 'dir':expand('%:p:h') })

" customize Rg with preview
let $BAT_THEME = 'TwoDark'
let $FZF_PREVIEW_COMMAND = 'bat --color=always {} || cat {} || tree -C {}'
let g:fzf_layout = { 'down': '~50%' }
" fzf now has Rg command built in
nnoremap <silent> <Leader>f :Rg<CR>

" coc.nvim
" coc configuration
" Use C to open coc config
call SetupCommandAbbrs('C', 'CocConfig')

" GOTO of coc
nmap <silent> <F12> <Plug>(coc-definition)

" using tab to cycle through suggestion list
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" : "\<TAB>"

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" coc-prettier
" :Prettier command
command! -nargs=0 Prettier :CocCommand prettier.formatFile
vmap <leader>p  <Plug>(coc-format-selected)
nmap <leader>p  <Plug>(coc-format-selected)

" git blamer
let g:blamer_enabled = 1
let g:blamer_delay = 500

" floatterm settings
let g:floaterm_keymap_toggle = '<F1>'
let g:floaterm_keymap_prev   = '<F2>'
let g:floaterm_keymap_next   = '<F3>'
let g:floaterm_keymap_new    = '<F4>'
let g:floaterm_gitcommit='floaterm'
let g:floaterm_autoinsert=1
let g:floaterm_width=0.8
let g:floaterm_height=0.8
let g:floaterm_wintitle=0
let g:floaterm_autoclose=1

" nvim-lspconfig
lua << EOF
-- treesitter
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true
  },
}
EOF
