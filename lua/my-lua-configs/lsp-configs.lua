require("neodev").setup({})

local format_group = vim.api.nvim_create_augroup("LspFormatting", {})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

local function on_attach(client, bufnr)
  local function bufmap(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, noremap = true, desc = desc })
  end

  vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

  bufmap("n", "gD", vim.lsp.buf.declaration, "LSP declaration")
  bufmap("n", "gd", "<cmd>Telescope lsp_definitions<cr>", "LSP definition")
  bufmap("n", "gr", vim.lsp.buf.references, "LSP references")
  bufmap("n", "gi", vim.lsp.buf.implementation, "LSP implementation")
  bufmap("n", "K", vim.lsp.buf.hover, "Hover docs")
  bufmap("n", "<C-k>", vim.lsp.buf.signature_help, "Signature help")
  bufmap("n", "<space>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
  bufmap("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
  bufmap("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "List workspace folders")
  bufmap("n", "<space>D", vim.lsp.buf.type_definition, "Type definition")
  bufmap("n", "<space>rn", vim.lsp.buf.rename, "Rename symbol")
  bufmap("n", "<space>ca", vim.lsp.buf.code_action, "Code action")
  bufmap("n", "<space>e", vim.diagnostic.open_float, "Line diagnostics")
  bufmap("n", "<space>q", vim.diagnostic.setloclist, "Diagnostics to loclist")
  bufmap("n", "[d", vim.diagnostic.goto_prev, "Prev diagnostic")
  bufmap("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
  bufmap("n", "F", function()
    vim.lsp.buf.format({ async = true })
  end, "Format buffer")

  require("lsp_signature").on_attach({}, bufnr)

  if client.name ~= "efm" then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  else
    vim.api.nvim_clear_autocmds({ group = format_group, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = format_group,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end,
    })
  end
end

local servers = {
  "gopls",
  "pyright",
  "terraformls",
  "tailwindcss",
}

local function enable(server, opts)
  return vim.lsp.enable(server, vim.tbl_deep_extend("force", {
    capabilities = capabilities,
    on_attach = on_attach,
  }, opts or {}))
end

for _, server in ipairs(servers) do
  enable(server)
end

enable("ts_ls", {
  handlers = {
    ["textDocument/publishDiagnostics"] = function() end,
  },
})

local eslint = {
  lintCommand = "./node_modules/.bin/eslint -f visualstudio --stdin --stdin-filename ${INPUT}",
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {
    "%f(%l,%c): %tarning %m",
    "%f(%l,%c): %rror %m",
  },
  formatCommand = "./node_modules/.bin/eslint --fix-to-stdout --stdin --stdin-filename=${INPUT}",
  formatStdin = true,
}

local prettier = { formatCommand = "./node_modules/.bin/prettier --stdin-filepath ${INPUT}", formatStdin = true }

local efm_languages = {
  yaml = { prettier },
  json = { prettier },
  markdown = { prettier },
  javascript = { eslint, prettier },
  javascriptreact = { eslint, prettier },
  ["javascript.jsx"] = { eslint, prettier },
  typescript = { eslint, prettier },
  typescriptreact = { eslint, prettier },
  ["typescript.tsx"] = { eslint, prettier },
  css = { prettier },
  scss = { prettier },
  sass = { prettier },
  less = { prettier },
  html = { prettier },
}

require('lspconfig').efm.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    rootMarkers = { ".git/", "package.json", ".zshrc" },
    languages = efm_languages,
  },
  init_options = { documentFormatting = true },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "json",
    "html",
  },
})

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

enable("lua_ls", {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = runtime_path,
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

enable("clangd", {
  cmd = {
    "clangd",
    "--offset-encoding=utf-16",
  },
})
