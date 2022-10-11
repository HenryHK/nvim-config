-- lualine
require('lualine').setup {
    options = {
        theme = 'tokyonight',
    },
    sections = {},
    inactive_sections={ },
    winbar = {
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
    inactive_winbar={
        lualine_a = {{'filename', file_status = true, path = 1}},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    }
}
