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
local cmp_capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local format_async = function(err, _, result, _, bufnr)
    if err ~= nil or result == nil then return end
    if not vim.api.nvim_buf_get_option(bufnr, "modified") then
        local view = vim.fn.winsaveview()
        vim.lsp.util.apply_text_edits(result, bufnr)
        vim.fn.winrestview(view)
        if bufnr == vim.api.nvim_get_current_buf() then vim.api.nvim_command("noautocmd :update") end
    end
end

vim.lsp.handlers["textDocument/formatting"] = format_async

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach_base = function(client, bufnr)
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
  buf_set_keymap('n', 'F', '<cmd>lua vim.lsp.buf.formatting_sync()<CR>', opts)

  require "lsp_signature".on_attach()

  if client.name ~= 'efm' then
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false
  end

  vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting_sync(nil, 2000)")
  if client.resolved_capabilities.document_formatting then
      vim.api.nvim_exec([[
       augroup LspAutocommands
           autocmd! * <buffer>
           autocmd BufWritePost <buffer> LspFormatting
       augroup END
       ]], true)
  end
end


-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
-- golang
nvim_lsp['gopls'].setup {
    capabilities = cmp_capabilities,
    on_attach = on_attach_base,
}

-- js
nvim_lsp['tsserver'].setup {
    capabilities = cmp_capabilities,
    on_attach = on_attach_base,
    handlers = {
        ['textDocument/publishDiagnostics'] = function(...) end --disable tsserver diagnostics as we use efm now
    },
}

-- config efm
local eslint = {
  lintCommand = 'eslint_d -f visualstudio --stdin --stdin-filename ${INPUT}',
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {
    "%f(%l,%c): %tarning %m",
    "%f(%l,%c): %rror %m"
  },
  formatCommand = 'eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}',
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
  json = { prettier },
  html = { prettier }
}

nvim_lsp['efm'].setup {
    init_options = {documentFormatting = true},
    settings = {
        rootMarkers = {'.git/', 'package.json', '.zshrc'},
        languages = efm_languages,
    },
    capabilities = capabilities,
    on_attach = on_attach_base,
    filetypes = {
        'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx', 'json', 'html'
    },
}

-- overwrite goto definition to open in a split window
-- local function goto_definition(split_cmd)
  -- local util = vim.lsp.util
  -- local log = require("vim.lsp.log")
  -- local api = vim.api

  -- -- note, this handler style is for neovim 0.5.1/0.6, if on 0.5, call with function(_, method, result)
  -- local handler = function(_, result, ctx)
    -- if result == nil or vim.tbl_isempty(result) then
      -- local _ = log.info() and log.info(ctx.method, "No location found")
      -- return nil
    -- end

    -- if split_cmd then
      -- vim.cmd(split_cmd)
    -- end

    -- if vim.tbl_islist(result) then
      -- util.jump_to_location(result[1])

      -- if #result > 1 then
        -- util.set_qflist(util.locations_to_items(result))
        -- api.nvim_command("copen")
        -- api.nvim_command("wincmd p")
      -- end
    -- else
      -- util.jump_to_location(result)
    -- end
  -- end

  -- return handler
-- end

-- vim.lsp.handlers["textDocument/definition"] = goto_definition('vsplit')
