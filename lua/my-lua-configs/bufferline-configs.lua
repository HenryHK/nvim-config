vim.opt.termguicolors = true
require("bufferline").setup{
    options = {
        mode="tabs",
        numbers = "ordinal",
        diagnostics = "nvim_lsp",
        always_show_bufferline = true,
        separator_style = "slant",
        offsets = {
            {
                filetype = "neo-tree",
                text = "File Explorer",
                text_align = "center",
                separator = true
            }
        }
    }
}
