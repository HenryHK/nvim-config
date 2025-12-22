local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

vim.cmd([[filetype plugin indent on]])
vim.cmd([[syntax enable]])
vim.cmd([[syntax sync minlines=256]])

local number_group = augroup("NumberToggle", { clear = true })
autocmd("InsertLeave", {
  group = number_group,
  callback = function()
    vim.opt.relativenumber = false
    vim.opt.number = true
  end,
})
autocmd("InsertEnter", {
  group = number_group,
  callback = function()
    vim.opt.relativenumber = true
  end,
})

local indent_group = augroup("LanguageIndent", { clear = true })
autocmd("FileType", {
  group = indent_group,
  pattern = { "javascript", "javascriptreact", "javascript.jsx" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = false
  end,
})

autocmd({ "BufNewFile", "BufReadPost" }, {
  group = indent_group,
  pattern = "*.coffee",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
    vim.opt_local.foldmethod = "manual"
  end,
})

autocmd("FileType", {
  group = indent_group,
  pattern = "json",
  callback = function()
    vim.cmd([[syntax match Comment +\/\/.\+$+]])
  end,
})

local checktime_group = augroup("Checktime", { clear = true })
autocmd({ "BufEnter", "FocusGained", "FocusLost", "WinLeave" }, {
  group = checktime_group,
  callback = function()
    if vim.fn.has("gui_running") == 0 then
      vim.cmd("silent! checktime")
    end
  end,
})
