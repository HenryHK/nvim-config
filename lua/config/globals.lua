local g = vim.g

g.mapleader = " "
g.maplocalleader = " "

-- Floaterm configuration
g.floaterm_keymap_toggle = "<F1>"
g.floaterm_keymap_prev = "<F2>"
g.floaterm_keymap_next = "<F3>"
g.floaterm_keymap_new = "<F4>"
g.floaterm_gitcommit = "floaterm"
g.floaterm_autoinsert = 1
g.floaterm_width = 0.8
g.floaterm_height = 0.8
g.floaterm_wintitle = 0
g.floaterm_autoclose = 1

-- FZF defaults
g.fzf_layout = { down = "~50%" }
vim.env.BAT_THEME = "TwoDark"
vim.env.FZF_PREVIEW_COMMAND = "bat --color=always {} || cat {} || tree -C {}"

g.copilot_no_tab_map = true
g.copilot_node_command = "/Users/lhan/.nvm/versions/node/v22.20.0/bin/node"
g.skip_ts_context_commentstring_module = true
g.neo_tree_remove_legacy_commands = 1
