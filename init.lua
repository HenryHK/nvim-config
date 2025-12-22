if vim.loader then
  vim.loader.enable()
end

require("config.globals")
require("config.options")
require("config.autocmds")
require("config.keymaps")
require("config.lazy")

pcall(vim.cmd.colorscheme, "gruvbox")
