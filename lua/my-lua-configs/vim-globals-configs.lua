-------------
-- Globals --
-------------
vim.g.mapleader = " "

-- vim-go
-- vim.g.go_metalinter_command='golangci-lint run --print-issued-lines=false --build-tags --exclude-use-default=use'

-- floatterm settings
vim.g.floaterm_keymap_toggle = '<F1>'
vim.g.floaterm_keymap_prev   = '<F2>'
vim.g.floaterm_keymap_next   = '<F3>'
vim.g.floaterm_keymap_new    = '<F4>'
vim.g.floaterm_gitcommit='floaterm'
vim.g.floaterm_autoinsert=1
vim.g.floaterm_width=0.8
vim.g.floaterm_height=0.8
vim.g.floaterm_wintitle=0
vim.g.floaterm_autoclose=1

-- fzf settings
vim.g.fzf_layout = {
    down = '~50%',
}
vim.env.BAT_THEME = 'TwoDark'
vim.env.FZF_PREVIEW_COMMAND = 'bat --color=always {} || cat {} || tree -C {}'

-- SimpylFold
vim.g.SimpylFold_docstring_preview = 1

-- NERD commenter
vim.g.NERDSpaceDelims = 1

-- Flutter Configuration I don't use this anymore
-- vim.g.dart_style_guide = 2
-- let dart_html_in_string=v:true
vim.g.copilot_no_tab_map = 1
vim.g.copilot_node_command = "/Users/lhan/.nvm/versions/node/v20.14.0/bin/node"
vim.g.skip_ts_context_commentstring_module = true
