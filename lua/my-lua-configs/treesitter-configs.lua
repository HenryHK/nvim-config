-- treesitter
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
    disable = {"go"}
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
}

-- treesitter textobjects
require'nvim-treesitter.configs'.setup {
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
      -- You can choose the select mode (default is charwise 'v')
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V', -- linewise
        ['@class.outer'] = '<c-v>', -- blockwise
      },
      -- If you set this to `true` (default is `false`) then any textobject is
      -- extended to include preceding xor succeeding whitespace. Succeeding
      -- whitespace has priority in order to act similarly to eg the built-in
      -- `ap`.
      include_surrounding_whitespace = true,
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  },
}

local treesitter_context = function(width)
  local type_patterns = {
    "class",
    "function",
    'method',
    'for',
    'while',
    'if',
    'switch',
    'case',
    'interface',
  }

  if vim.o.ft == "json" then
    type_patterns = { "object", "pair" }
  end

  local f = require("nvim-treesitter").statusline({
    indicator_size = width,
    type_patterns = type_patterns,
    transform_fn = function (line)
        line = line:gsub('%s*[%[%(%{]*%s*$', '')
        local r = vim.fn.substitute(line, "\\((.\\{-})\\)", "", "g")
        r = vim.fn.substitute(r, "  ", " ", "g")
        return r
    end,
  })
  local context = string.format("%s", f) -- convert to string, it may be a empty ts node

  if context == "vim.NIL" then
    return " "
  end

  return " " .. context
end

return {
  context = treesitter_context,
}
