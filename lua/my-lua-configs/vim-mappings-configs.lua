--------------
-- Mappings --
--------------
-- wrappers
local function map(mode, shortcut, command, expr)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true, expr=expr })
end

local function nmap(shortcut, command)
  map('n', shortcut, command)
end

local function imap(shortcut, command)
  map('i', shortcut, command)
end

function SwitchCase()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  local word = vim.fn.expand('<cword>')
  local word_start = vim.fn.matchstrpos(vim.fn.getline('.'), '\\k*\\%' .. (col+1) .. 'c\\k*')[2]

  -- Detect camelCase
  if word:find('[a-z][A-Z]') then
    -- Convert camelCase to snake_case
    local snake_case_word = word:gsub('([a-z])([A-Z])', '%1_%2'):lower()
    vim.api.nvim_buf_set_text(0, line - 1, word_start, line - 1, word_start + #word, {snake_case_word})
  -- Detect snake_case
  elseif word:find('_[a-z]') then
    -- Convert snake_case to camelCase
    local camel_case_word = word:gsub('(_)([a-z])', function(_, l) return l:upper() end)
    vim.api.nvim_buf_set_text(0, line - 1, word_start, line - 1, word_start + #word, {camel_case_word})
  else
    print("Not a snake_case or camelCase word")
  end
end

-- remap <ESC>
map('i', 'jj', '<ESC>')
map('', '<ESC><ESC>', ':noh<return>')

-- indentation move
map('v', '<', '<gv')
map('v', '>', '>gv')

-- pane, window, tab movement
map('n', 'H', 'gT')
map('n', 'L', 'gt')
map('n', '<C-J>', '<C-W><C-J>')
map('n', '<C-K>', '<C-W><C-K>')
map('n', '<C-L>', '<C-W><C-L>')
map('n', '<C-H>', '<C-W><C-H>')
map('n', '<S-Up>',    '<C-w>+')
map('n', '<S-Down>',  '<C-w>-')
map('n', '<S-Right>', '<C-w>>')
map('n', '<S-Left>',  '<C-w><')

-- tagbar
map('n', '<F9>',  ':TagbarToggle<CR>')

-- gitgutter
map('n', '<right><right>', ':GitGutterNextHunk<CR>')
map('n', '<left><left>', ':GitGutterPrevHunk<CR>')
map('n', 'gua', ':GitGutterUndoHunk<CR>')
map('n', 'gpr', ':GitGutterPreviewHunk<CR>')

-- map('n', '<leader>f', '<cmd>lua require "telescope.builtin".grep_string{ shorten_path = true, word_match = "-w", only_sort_text = true, search = "" }<CR>')
map('n', '<leader>f', ':Rg<CR>')
map('n', '<C-p>', '<cmd>Telescope find_files<cr>')
map('n', '<C-g>', '<cmd>Telescope git_status<cr>')
map('n', '<C-e>', '<cmd>Telescope buffers<cr>')
map('n', '<C-t>', '<cmd>SymbolsOutline<cr>')

map('n', '<C-n>', ':Neotree toggle<CR>')
-- map('n', '<leader>r', ':NvimTreeRefresh<CR>')
-- map('n', '<leader>n', ':NvimTreeFindFile<CR>')

map('n', 'gpd', '<cmd>lua require("goto-preview").goto_preview_definition()<CR>')
map('n', '<F12>', '<cmd>lua require("goto-preview").goto_preview_definition()<CR>')
map('n', 'gpi', '<cmd>lua require("goto-preview").goto_preview_implementation()<CR>')
map('n', 'gP', '<cmd>lua require("goto-preview").close_all_win()<CR>')
map('n', 'gpr', '<cmd>lua require("goto-preview").goto_preview_references()<CR>')
imap('gpr', '<cmd>lua require("goto-preview").goto_preview_references()<CR>')
map("i", "'\"", 'copilot#Accept("<CR>")', true)
-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
map('n', 'zR', '<cmd>lua require("ufo").openAllFolds()<CR>')
map('n', 'zM', '<cmd>lua require("ufo").closeAllFolds()<CR>')
-- trouble
nmap('<C-d>', ':TroubleToggle<CR>')
-- snake_case <-> camelCase
map('n', '<leader>cc', ':lua SwitchCase()<CR>')
