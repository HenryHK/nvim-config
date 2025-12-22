return {
  -- Theme
  { "ellisonleao/gruvbox.nvim", priority = 1000, lazy = false },
  { "folke/tokyonight.nvim", priority = 900 },
  { "rktjmp/lush.nvim", lazy = true },

  -- Core dependencies
  { "nvim-lua/plenary.nvim", lazy = true },
  { "nvim-tree/nvim-web-devicons", lazy = true },
  { "MunifTanjim/nui.nvim", lazy = true },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require("my-lua-configs.snacks-configs")
    end,
  },

  -- UI
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("my-lua-configs.alpha-configs")
    end,
  },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("my-lua-configs.bufferline-configs")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("my-lua-configs.lualine-configs")
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
    config = function()
      require("my-lua-configs.neotree-configs")
    end,
  },
  { "shortcuts/no-neck-pain.nvim", cmd = "NoNeckPain", version = "*" },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("my-lua-configs.which-key-configs")
    end,
  },

  -- Git
  { "tpope/vim-fugitive", cmd = { "G", "Git", "Gdiffsplit", "Gvdiffsplit", "GBrowse", "Gblame", "Gread" } },
  { "tpope/vim-rhubarb", event = "VeryLazy" },
  { "airblade/vim-gitgutter", event = { "BufReadPre", "BufNewFile" } },
  { "APZelos/blamer.nvim", event = "BufReadPost" },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("my-lua-configs.diffview-configs")
    end,
  },
  { "preservim/tagbar", cmd = "TagbarToggle" },

  -- Terminal
  {
    "voldikss/vim-floaterm",
    cmd = { "FloatermToggle", "FloatermNew", "FloatermPrev", "FloatermNext" },
    keys = {
      { "<F1>", "<cmd>FloatermToggle<CR>", desc = "Floaterm Toggle" },
      { "<F2>", "<cmd>FloatermPrev<CR>", desc = "Floaterm Prev" },
      { "<F3>", "<cmd>FloatermNext<CR>", desc = "Floaterm Next" },
      { "<F4>", "<cmd>FloatermNew<CR>", desc = "Floaterm New" },
    },
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("my-lua-configs.treesitter-configs")
    end,
  },

  -- Editing helpers
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    config = function()
      require("my-lua-configs.comment-configs")
    end,
  },
  {
    "kylechui/nvim-surround",
    event = "BufReadPost",
    config = function()
      require("my-lua-configs.nvim-surround-configs")
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("my-lua-configs.indent-blankline-configs")
    end,
  },

  -- LSP / completion
  { "folke/neodev.nvim", ft = "lua", opts = {} },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "folke/neodev.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "ray-x/lsp_signature.nvim",
    },
    config = function()
      require("my-lua-configs.lsp-configs")
    end,
  },
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup({})
    end,
  },
  {
    "simrat39/rust-tools.nvim",
    ft = { "rust", "rs" },
    config = function()
      require("my-lua-configs.rust-tools")
    end,
  },
  {
    "crispgm/nvim-go",
    ft = "go",
    config = function()
      require("my-lua-configs.go-configs")
    end,
  },
  {
    "akinsho/flutter-tools.nvim",
    ft = "dart",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("my-lua-configs.flutter-configs")
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
      "onsails/lspkind-nvim",
    },
    config = function()
      require("my-lua-configs.cmp-configs")
    end,
  },
  { "hrsh7th/cmp-nvim-lsp", event = "InsertEnter" },
  { "hrsh7th/cmp-buffer", event = "InsertEnter" },
  { "hrsh7th/cmp-path", event = "InsertEnter" },
  { "hrsh7th/cmp-cmdline", event = "CmdlineEnter" },
  { "hrsh7th/cmp-nvim-lua", ft = "lua" },
  { "hrsh7th/cmp-vsnip", event = "InsertEnter" },
  { "hrsh7th/vim-vsnip", event = "InsertEnter" },
  { "onsails/lspkind-nvim", event = "VeryLazy" },
  { "ray-x/lsp_signature.nvim", event = "LspAttach" },
  { "ggandor/lightspeed.nvim", event = "VeryLazy" },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    config = function()
      require("my-lua-configs.trouble-configs")
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    config = function()
      require("my-lua-configs.noice-configs")
    end,
  },
  { "rcarriga/nvim-notify", event = "VeryLazy" },
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    config = function()
      require("my-lua-configs.symbols-outline-configs")
    end,
  },
  { "kevinhwang91/promise-async", lazy = true },
  {
    "kevinhwang91/nvim-ufo",
    event = "BufReadPost",
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
      require("my-lua-configs.ufo-configs")
    end,
  },
  {
    "rmagatti/goto-preview",
    event = "LspAttach",
    config = function()
      require("my-lua-configs.goto-preview-configs")
    end,
  },

  -- Telescope / search
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      require("my-lua-configs.telescope-configs")
    end,
  },
  { "junegunn/fzf", build = "./install --bin", event = "VeryLazy" },
  { "junegunn/fzf.vim", event = "VeryLazy", dependencies = { "junegunn/fzf" } },

  -- GitHub Copilot
  { "github/copilot.vim", event = "InsertEnter" },

  -- Utils
  { "wakatime/vim-wakatime", event = "VeryLazy" },
  { "tpope/vim-obsession", cmd = "Obsession" },
  { "mfussenegger/nvim-dap", lazy = true },
}
