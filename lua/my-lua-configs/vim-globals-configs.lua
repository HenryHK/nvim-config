-------------
-- Globals --
-------------
vim.g.mapleader = " "

-- vim-go
vim.g.go_fmt_command = "goimports"
vim.g.go_auto_type_info = 1
vim.g.go_addtags_transform = "snakecase"
vim.g.go_def_mode = 'gopls'
vim.g.go_info_mode = 'gopls'
vim.g.go_metalinter_command='golangci-lint run --print-issued-lines=false --build-tags --exclude-use-default=use'

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

-- nvim-tree settings
vim.g.nvim_tree_git_hl = 1 
vim.g.nvim_tree_highlight_opened_files = 1 
vim.g.nvim_tree_add_trailing = 1 
vim.g.nvim_tree_icon_padding = ' ' 
vim.g.nvim_tree_symlink_arrow = ' >> ' 
vim.g.nvim_tree_create_in_closed_folder = 0 
vim.g.nvim_tree_refresh_wait = 1000 

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
