require('noice').setup({
  history = {
    -- options for the message history that you get with `:Noice`
    view = "popup",
    opts = { enter = true, format = "details" },
    filter = { event = { "msg_show", "notify" }, ["not"] = { kind = { "search_count", "echo" } } },
  },
  lsp_progress = {
    enabled = true,
    -- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
    -- See the section on formatting for more details on how to customize.
    --- @type NoiceFormat|string
    format = "lsp_progress",
    --- @type NoiceFormat|string
    format_done = "lsp_progress_done",
    throttle = 1000 / 30, -- frequency to update lsp progress message
  },
  views = {
    popupmenu = {
        zindex = 65,
        position = "auto", -- when auto, then it will be positioned to the cmdline or cursor
        size = {
          width = "auto",
          -- min_width = 10,
        },
        win_options = {
          winhighlight = {
            Normal = "NormalFloat", -- change to NormalFloat to make it look like other floats
            FloatBorder = "FloatBorder", -- border highlight
            CursorLine = "NoicePopupmenuSelected", -- used for highlighting the selected item
            PmenuMatch = "NoicePopupmenuMatch", -- used to highlight the part of the item that matches the input
          },
        },
        border = {
          padding = { 0, 1 },
        },
    },
    popup = {
        backend = "popup",
        close = {
          events = { "BufLeave" },
          keys = { "q", "<esc>" },
        },
        enter = true,
        border = {
          style = "single",
        },
        position = "50%",
        size = {
          width = "80%",
          height = "60%",
        },
        win_options = {
          winhighlight = { Normal = "NormalFloat", FloatBorder = "FloatBorder" },
        },
      },
  },
})
