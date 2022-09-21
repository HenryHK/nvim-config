--------------
-- Mappings --
--------------
-- wrappers
function map(mode, shortcut, command, expr)
  name = false or expr
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true, expr=expr })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

function imap(shortcut, command)
  map('i', shortcut, command)
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

map('n', '<leader>f', '<cmd>lua require "telescope.builtin".grep_string{ shorten_path = true, word_match = "-w", only_sort_text = true, search = "" }<CR>')
map('n', '<C-p>', '<cmd>Telescope find_files<cr>')
map('n', '<C-g>', '<cmd>Telescope git_status<cr>')
map('n', '<C-e>', '<cmd>Telescope buffers<cr>')
map('n', '<C-t>', '<cmd>SymbolsOutline<cr>')

map('n', '<C-n>', ':NvimTreeToggle<CR>')
map('n', '<leader>r', ':NvimTreeRefresh<CR>')
map('n', '<leader>n', ':NvimTreeFindFile<CR>')

map('n', 'gpd', '<cmd>lua require("goto-preview").goto_preview_definition()<CR>')
map('n', '<F12>', '<cmd>lua require("goto-preview").goto_preview_definition()<CR>')
map('n', 'gpi', '<cmd>lua require("goto-preview").goto_preview_implementation()<CR>')
map('n', 'gP', '<cmd>lua require("goto-preview").close_all_win()<CR>')
map('n', 'gpr', '<cmd>lua require("goto-preview").goto_preview_references()<CR>')
map('i', 'gpr', '<cmd>lua require("goto-preview").goto_preview_references()<CR>')
map("i", "''", 'copilot#Accept("<CR>")', true)
-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
map('n', 'zR', 'lua require("ufo").openAllFolds')
map('n', 'zM', 'lua require("ufo").closeAllFolds')
