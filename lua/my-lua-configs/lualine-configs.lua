-- lualine
require('lualine').setup {
    options = {
        theme = 'tokyonight',
    },
    sections = {
        lualine_a = {
            {
              'filename',
              file_status = true, -- displays file status (readonly status, modified status)
              path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
            }
        },
        lualine_c = {},
    },
    inactive_sections={
        lualine_a = {},
        lualine_b = {},
        lualine_c = {{'filename', file_status = true, path = 1}},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    }
}
