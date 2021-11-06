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
  },
  formatting = {
    format = lspkind.cmp_format({with_text = false, maxwidth = 50})
  },
}
 -- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig')['gopls'].setup {
    capabilities = capabilities
}
require('lspconfig')['tsserver'].setup {
    capabilities = capabilities
}
