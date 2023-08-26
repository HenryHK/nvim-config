-- setup neodev before lspconfig
require("neodev").setup({
  -- add any options here, or leave empty to use the default settings
})

-- nvim lsp config
local nvim_lsp = require('lspconfig')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.documentationFormat = { 'markdown', 'plaintext' }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  },
}
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', 'F', '<cmd>lua vim.lsp.buf.format()<CR>', opts)

  require "lsp_signature".on_attach()
  if client.name ~= 'efm' then
      client.server_capabilities.documentFormattingProvider= false
      client.server_capabilities.documentRangeFormattingProvide = false
  end

  vim.cmd("command! LspFormatting lua vim.lsp.buf.format()")
  if client.name == 'efm' then
      vim.api.nvim_exec([[
       augroup LspAutocommands
           autocmd! * <buffer>
           autocmd BufWritePre <buffer> LspFormatting
       augroup END
       ]], true)
  end
end


-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
-- golang
nvim_lsp['gopls'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

-- js/ts/jsx/tsx
nvim_lsp['tsserver'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    handlers = {
        ['textDocument/publishDiagnostics'] = function(...) end --disable tsserver diagnostics as we use efm now
    },
}

-- config efm
local eslint = {
  lintCommand = './node_modules/.bin/eslint -f visualstudio --stdin --stdin-filename ${INPUT}',
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {
    "%f(%l,%c): %tarning %m",
    "%f(%l,%c): %rror %m"
  },
  formatCommand = './node_modules/.bin/eslint --fix-to-stdout --stdin --stdin-filename=${INPUT}',
  formatStdin = true,
}

local prettier = {formatCommand = './node_modules/.bin/prettier --stdin-filepath ${INPUT}', formatStdin = true}

local efm_languages = {
  yaml = { prettier },
  json = { prettier },
  markdown = { prettier },
  javascript = { eslint, prettier },
  javascriptreact = { eslint, prettier },
  typescript = { eslint, prettier },
  typescriptreact = { eslint , prettier},
  css = { prettier },
  scss = { prettier },
  sass = { prettier },
  less = { prettier },
  html = { prettier }
}

nvim_lsp['efm'].setup {
    settings = {
        rootMarkers = {'.git/', 'package.json', '.zshrc'},
        languages = efm_languages,
    },
    init_options = {documentFormatting = true},
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = {
        'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx', 'json', 'html'
    },
}

-- setting up lua
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')
-- config lua for neovim
nvim_lsp['lua_ls'].setup({
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = runtime_path,
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file('', true),
                checkThirdParty = false,
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
})

nvim_lsp['tailwindcss'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

require("lspsaga").setup({})
