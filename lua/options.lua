-------------
-- Options --
-------------
vim.opt.compatible = false
vim.opt.background = 'dark' -- or light if you want light mode
vim.opt.cursorcolumn = false-- improve neovim performance slightly
vim.opt.cursorline = false-- improve neovim performance slightly
vim.opt.scrolljump = 5 -- vim.opt.layout format
vim.opt.fileencoding ='utf-8' -- file encoding
vim.opt.fileencodings ='ucs-bom,utf-8,gbk,cp936,latin-1'
vim.opt.tabstop = 4 -- use space to all tab, vim.opt.indentation to 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.number = true -- turn on line number
vim.opt.lazyredraw = true -- turn on lazy redraw to improve big regex etc.
vim.opt.incsearch = true -- find as typing
vim.opt.hlsearch = true -- highlight search terms
vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true -- if search input contains upper case, do not ignore
vim.opt.mouse = 'a'-- allow to use mouse
vim.opt.spell = false -- turn off spell check
vim.opt.autoindent = true -- smart indentation
vim.opt.showmatch = true -- show matched brackets and so on
vim.opt.foldmethod = 'expr' -- fold method
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()' -- use treesitter
vim.opt.foldenable = false
vim.opt.synmaxcol = 0
vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes' -- always show signcolumns
