-- nvim-cmp setup
local cmp = require 'cmp'
local lspkind = require('lspkind')
cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  mapping= {
    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
    }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'cmp_tabnine' },
    { name = 'vsnip' }, -- For vsnip users.
    { name = 'path' },
    { name = 'buffer' },
  },
  formatting = {
    format = lspkind.cmp_format({with_text = true, maxwidth = 50})
  },
}
