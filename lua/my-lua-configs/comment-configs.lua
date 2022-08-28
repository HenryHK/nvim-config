local context_aware_filetypes = {}
context_aware_filetypes['javascript']  = true
context_aware_filetypes['javascriptreact']  = true
context_aware_filetypes['javascript.jsx']  = true
context_aware_filetypes['typescript']= true
context_aware_filetypes['typescriptreact']  = true
context_aware_filetypes['typescript.tsx']  = true

require('Comment').setup({
    pre_hook = function(ctx)
        -- Only calculate commentstring for tsx filetypes
        if context_aware_filetypes[vim.bo.filetype] then
            local U = require('Comment.utils')

            -- Determine whether to use linewise or blockwise commentstring
            local type = ctx.ctype == U.ctype.line and '__default' or '__multiline'

            -- Determine the location where to calculate commentstring from
            local location = nil
            if ctx.ctype == U.ctype.blockwise then
                location = require('ts_context_commentstring.utils').get_cursor_location()
            elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
                location = require('ts_context_commentstring.utils').get_visual_start_location()
            end

            return require('ts_context_commentstring.internal').calculate_commentstring({
                key = type,
                location = location,
            })
        end
    end,
    post_hook = function(ctx)
        if ctx.range.srow == ctx.range.erow then
            -- do something with the current line
        else
            -- do something with lines range
        end
    end,
})
