local tree_cb = require'nvim-tree.config'.nvim_tree_callback
require'nvim-tree'.setup{
    view = {
        mappings = {
            list = {
                { key = "s", cb = tree_cb("system_open") },
            }
        }
    }
}
