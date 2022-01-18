-------------
---- CMD ----
-------------
vim.cmd([[
" toggle file type on
filetype on
" toggle plugin on
filetype plugin on
" toggle plugin indent on
filetype plugin indent on

" colorscheme
" colorscheme gruvbox
colorscheme tokyonight

" abosolute line number in normal mode
" relative line number in insert mode
autocmd InsertLeave * :set norelativenumber number
autocmd InsertEnter * :set relativenumber

" syntax on
if !exists('g:syntax_on')
	syntax enable
endif
syntax sync minlines=256

" filetype specific settings
" js etc.
autocmd FileType javascript.jsx setlocal tabstop=2 shiftwidth=2 noexpandtab
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 noexpandtab
autocmd BufNewFile,BufReadPost *.coffee setl tabstop=2 shiftwidth=2 expandtab foldmethod=manual
autocmd FileType json syntax match Comment +\/\/.\+$+
" golang
autocmd BufWritePre *.go :GoBuild

" magic to fzf with git
command! -bang Gbranch call fzf#run({ 'source': s:gitListRefs(), 'sink': function('s:gitCheckoutRef'), 'dir':expand('%:p:h') })

]])
