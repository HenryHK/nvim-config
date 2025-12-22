local snacks = require("snacks")

snacks.setup({
  -- Enable Snacks input/picker to replace vim.ui.input/select (was dressing.nvim)
  input = { enabled = true },
  picker = {
    enabled = true,
    ui_select = true,
  },
})
