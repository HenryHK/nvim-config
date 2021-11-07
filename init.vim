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

" nvim-tree - to replce nerdtree
Plug 'kyazdani42/nvim-tree.lua'

" lualine - to replace airline
Plug 'nvim-lualine/lualine.nvim'
" lua fork of vim-devicons
Plug 'kyazdani42/nvim-web-devicons'

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

" EasyFold only for Python
Plug 'tmhedberg/SimpylFold'
let g:SimpylFold_docstring_preview = 1

" Vim JavaScript
Plug 'chemzqm/vim-jsx-improve'
Plug 'w0rp/ale'

" Vim JSON
Plug 'elzr/vim-json'

" session management
Plug 'tpope/vim-obsession'

" gruv color schema
Plug 'rktjmp/lush.nvim'
Plug 'ellisonleao/gruvbox.nvim'

" floatterm, simply the best
Plug 'voldikss/vim-floaterm'

" TreeSitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" wakatime
Plug 'wakatime/vim-wakatime'

" copilot
Plug 'github/copilot.vim'

" nvim lsp config
Plug 'neovim/nvim-lspconfig'

" autocomplete plugin
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/nvim-cmp'
" nvim-cmp snippet: vsnip
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
" nvim-cmp tabnine
Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
" nvim-cmp lspkind
Plug 'onsails/lspkind-nvim'
" indent blankline
Plug 'lukas-reineke/indent-blankline.nvim'
" lsp_signature
Plug 'ray-x/lsp_signature.nvim'

" telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" end of plugins settings
call plug#end()

" Beiginning of general configuration

" magic of using vim
set nocompatible

set background=dark " or light if you want light mode
colorscheme gruvbox

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

set lazyredraw
" find as typing
set incsearch
" highlight search terms
set hlsearch

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

set t_8f=^[[38;2;%lu;%lu;%lum
set t_8b=^[[48;2;%lu;%lu;%lum
set termguicolors

" sepcial indentation for jsx and coffeescript
autocmd FileType javascript.jsx setlocal tabstop=2 shiftwidth=2 noexpandtab
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 noexpandtab
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

" Ale configuration: lint plugin
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
let g:ale_lint_on_enter = 0 " Less distracting when opening a new file
let g:ale_fixers = {
    \ 'javascript': ['prettier','eslint'],
    \ 'css': ['prettier', 'eslint'] }
let g:ale_fix_on_save =1 
let g:ale_open_list = 0
let g:ale_linters_explicit = 1 " Don't use default linters unless specified

" Flutter Configuration
let g:dart_style_guide = 2
let dart_html_in_string=v:true

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

" TODO: remove this when telescope support fuzzy search for live grep search
" for now fzf is still the best choice to do grep fuzzy search
" customize Rg with preview
let $BAT_THEME = 'TwoDark'
let $FZF_PREVIEW_COMMAND = 'bat --color=always {} || cat {} || tree -C {}'
let g:fzf_layout = { 'down': '~50%' }
let g:fzf_action = {
  \ 'ctrl-e': 'edit',
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
" fzf now has Rg command built in
nnoremap <silent> <Leader>f :Rg<CR>

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

" telescope Settings
" Find files using Telescope command-line sugar.
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <C-g> <cmd>Telescope git_status<cr>
nnoremap <C-e> <cmd>Telescope buffers<cr>
nnoremap <C-t> <cmd>Telescope tags<cr>

" nvim tree settings
let g:nvim_tree_indent_markers = 1 "0 by default, this option shows indent markers when folders are open
let g:nvim_tree_git_hl = 1 "0 by default, will enable file highlight for git attributes (can be used without the icons).
let g:nvim_tree_highlight_opened_files = 1 "0 by default, will enable folder and file icon highlight for opened files/directories.
let g:nvim_tree_add_trailing = 1 "0 by default, append a trailing slash to folder names
let g:nvim_tree_icon_padding = ' ' "one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
let g:nvim_tree_symlink_arrow = ' >> ' " defaults to ' ➛ '. used as a separator between symlinks' source and target.
let g:nvim_tree_create_in_closed_folder = 0 "1 by default, When creating files, sets the path of a file when cursor is on a closed folder to the parent folder when 0, and inside the folder when 1.
let g:nvim_tree_refresh_wait = 500 "1000 by default, control how often the tree can be refreshed, 1000 means the tree can be refresh once per 1000ms.
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

" import lua config
lua require('lsp-configs')
lua require('treesitter-configs')
lua require('cmp-configs')
lua require('cmp-tabnine-configs')
lua require('indent-blankline-configs')
lua require('telescope-configs')
lua require('lualine-configs')
lua require('nvim-tree-configs')
