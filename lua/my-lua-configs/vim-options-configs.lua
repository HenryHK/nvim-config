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
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.opt.synmaxcol = 0
vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes' -- always show signcolumns
vim.opt.laststatus = 0 -- hide status line completely, we now use lualine on winbar

-- clipboard setting
-- See https://stackoverflow.com/questions/11489428/how-to-make-vim-paste-from-and-copy-to-systems-clipboard
if vim.fn.has('clipboard') == 1 then
  if vim.fn.has('unnamedplus') == 1 then
    vim.opt.clipboard="unnamed,unnamedplus"
  else
    vim.opt.clipboard="unnamed"
  end
end

