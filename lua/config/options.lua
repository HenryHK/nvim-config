local opt = vim.opt

opt.compatible = false
opt.cursorcolumn = false
opt.cursorline = false
opt.scrolljump = 5
opt.fileencoding = "utf-8"
opt.fileencodings = "ucs-bom,utf-8,gbk,cp936,latin-1"
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.number = true
opt.relativenumber = false
opt.incsearch = true
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"
opt.spell = false
opt.autoindent = true
opt.showmatch = true
opt.foldcolumn = "1"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true
opt.synmaxcol = 0
opt.termguicolors = true
opt.signcolumn = "yes"
opt.laststatus = 3

if vim.fn.has("clipboard") == 1 then
  if vim.fn.has("unnamedplus") == 1 then
    opt.clipboard = "unnamed,unnamedplus"
  else
    opt.clipboard = "unnamed"
  end
end
