-- lualine
require('lualine').setup {
    options = {
        theme = 'tokyonight',
    },
    winbar = {
        lualine_a = {
            "require('my-lua-configs.treesitter-configs').context()",
        },
    },
    -- inactive_sections={ },
    sections = {
        lualine_a = {
            {
              'filename',
              file_status = true, -- displays file status (readonly status, modified status)
              path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
            }
        },
        lualine_b = {'branch', 'diff', },
        lualine_c = {'diagnostics'},
        lualine_x = {'encoding', 'filetype'},
    },
    inactive_sections={
        lualine_a = {{'filename', file_status = true, path = 1}},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    }
}
