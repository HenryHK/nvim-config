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
colorscheme tokyonight-night


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
augroup NvimGo
    autocmd!
    autocmd User NvimGoLintPopupPost wincmd p
augroup END

" magic to fzf with git
command! -bang Gbranch call fzf#run({ 'source': s:gitListRefs(), 'sink': function('s:gitCheckoutRef'), 'dir':expand('%:p:h') })

augroup checktime
    autocmd!
    if !has("gui_running")
        "silent! necessary otherwise throws errors when using command
        "line window.
        autocmd BufEnter,FocusGained,BufEnter,FocusLost,WinLeave * checktime
    endif
augroup END
]])
