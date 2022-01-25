local tree_cb = require'nvim-tree.config'.nvim_tree_callback
require'nvim-tree'.setup{
    disable_netrw = false, -- netrw needed for rhubarb :GBrowse
    view = {
        mappings = {
            list = {
                { key = "s", cb = tree_cb("system_open") },
            }
        }
    }
}
