local map = vim.keymap.set

local function switch_case()
  local pos = vim.api.nvim_win_get_cursor(0)
  local line = pos[1]
  local col = pos[2]
  local word = vim.fn.expand("<cword>")
  local word_start = vim.fn.matchstrpos(vim.fn.getline("."), "\\k*\\%" .. (col + 1) .. "c\\k*")[2]

  if word:find("[a-z][A-Z]") then
    local snake_case_word = word:gsub("([a-z])([A-Z])", "%1_%2"):lower()
    vim.api.nvim_buf_set_text(0, line - 1, word_start, line - 1, word_start + #word, { snake_case_word })
  elseif word:find("_[a-z]") then
    local camel_case_word = word:gsub("(_)([a-z])", function(_, l)
      return l:upper()
    end)
    vim.api.nvim_buf_set_text(0, line - 1, word_start, line - 1, word_start + #word, { camel_case_word })
  else
    vim.notify("Not a snake_case or camelCase word", vim.log.levels.INFO)
  end
end

map("i", "jj", "<Esc>", { silent = true })
map({ "n", "v" }, "<Esc><Esc>", "<cmd>nohlsearch<CR>", { silent = true })

map("v", "<", "<gv", { silent = true })
map("v", ">", ">gv", { silent = true })

map("n", "H", "gT", { silent = true })
map("n", "L", "gt", { silent = true })
map("n", "<C-J>", "<C-W><C-J>", { silent = true })
map("n", "<C-K>", "<C-W><C-K>", { silent = true })
map("n", "<C-L>", "<C-W><C-L>", { silent = true })
map("n", "<C-H>", "<C-W><C-H>", { silent = true })
map("n", "<S-Up>", "<C-w>+", { silent = true })
map("n", "<S-Down>", "<C-w>-", { silent = true })
map("n", "<S-Right>", "<C-w>>", { silent = true })
map("n", "<S-Left>", "<C-w><", { silent = true })

map("n", "<F9>", "<cmd>TagbarToggle<CR>", { silent = true, desc = "Toggle Tagbar" })

map("n", "<Right><Right>", "<cmd>GitGutterNextHunk<CR>", { silent = true })
map("n", "<Left><Left>", "<cmd>GitGutterPrevHunk<CR>", { silent = true })
map("n", "gua", "<cmd>GitGutterUndoHunk<CR>", { silent = true })
map("n", "gpr", "<cmd>GitGutterPreviewHunk<CR>", { silent = true })

map("n", "<leader>f", "<cmd>Rg<CR>", { silent = true, desc = "Ripgrep project" })
map("n", "<C-p>", "<cmd>Telescope find_files<cr>", { silent = true })
map("n", "<C-g>", "<cmd>Telescope git_status<cr>", { silent = true })
map("n", "<C-e>", "<cmd>Telescope buffers<cr>", { silent = true })
map("n", "<C-t>", "<cmd>SymbolsOutline<cr>", { silent = true })
map("n", "gd", "<cmd>Telescope lsp_definitions<cr>", { silent = true, desc = "LSP definitions (Telescope)" })

map("n", "<C-n>", "<cmd>Neotree toggle<CR>", { silent = true, desc = "Toggle Neo-tree" })

map("n", "gpd", function()
  require("goto-preview").goto_preview_definition()
end, { silent = true })
map("n", "<F12>", function()
  require("goto-preview").goto_preview_definition()
end, { silent = true })
map("n", "gpi", function()
  require("goto-preview").goto_preview_implementation()
end, { silent = true })
map("n", "gP", function()
  require("goto-preview").close_all_win()
end, { silent = true })
map("n", "gpr", function()
  require("goto-preview").goto_preview_references()
end, { silent = true })
map("i", "gpr", function()
  require("goto-preview").goto_preview_references()
end, { silent = true })

map("i", "'\"", 'copilot#Accept("\\<CR>")', { silent = true, expr = true })

map("n", "zR", function()
  require("ufo").openAllFolds()
end, { silent = true })
map("n", "zM", function()
  require("ufo").closeAllFolds()
end, { silent = true })

map("n", "<C-d>", "<cmd>Trouble diagnostics toggle focus=false filter.buf=0<CR>", { silent = true })
map("n", "<leader>cc", switch_case, { silent = true, desc = "Toggle camelCase/snake_case" })
