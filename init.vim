" Plugins enabled using vim-plug
call plug#begin('~/.local/share/nvim/plugged')

" fast commenting
Plug 'numToStr/Comment.nvim'
" Add spaces after comment delimiters by default

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
" vim rust plugin
Plug 'simrat39/rust-tools.nvim'

" EasyFold only for Python
Plug 'tmhedberg/SimpylFold'

" Vim JSON
Plug 'elzr/vim-json'

" session management
Plug 'tpope/vim-obsession'

" gruv color schema
Plug 'rktjmp/lush.nvim'
Plug 'ellisonleao/gruvbox.nvim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

" floatterm, simply the best
Plug 'voldikss/vim-floaterm'

" TreeSitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'

" wakatime
Plug 'wakatime/vim-wakatime'

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

" goto-preview
Plug 'rmagatti/goto-preview'
" luatab - simply a tabline lua port
Plug 'alvarosevilla95/luatab.nvim'

" copilot
Plug 'github/copilot.vim'


" end of plugins settings
call plug#end()

lua << EOF
  for k, v in pairs(package.loaded) do
    if string.match(k, "^my-lua-configs") then
      package.loaded[k] = nil
    end
  end
EOF

" import lua config
lua require('my-lua-configs/vim-globals-configs')
lua require('my-lua-configs/vim-options-configs')
lua require('my-lua-configs/vim-cmd-configs')
lua require('my-lua-configs/lsp-configs')
lua require('my-lua-configs/treesitter-configs')
lua require('my-lua-configs/cmp-configs')
lua require('my-lua-configs/cmp-tabnine-configs')
lua require('my-lua-configs/indent-blankline-configs')
lua require('my-lua-configs/telescope-configs')
lua require('my-lua-configs/lualine-configs')
lua require('my-lua-configs/nvim-tree-configs')
lua require('my-lua-configs/goto-preview-configs')
lua require('my-lua-configs/comment-configs')
lua require('my-lua-configs/luatab-configs')
lua require('my-lua-configs/vim-mappings-configs')
lua require('my-lua-configs/rust-tools')
