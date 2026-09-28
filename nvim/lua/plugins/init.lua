return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- VS Code-like completion: LSP suggestions, snippets, buffer words, and paths.
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      return require("configs.cmp").setup(opts)
    end,
  },

  -- Show the beginning and end of the current indentation block.
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = function(_, opts)
      opts.indent = vim.tbl_deep_extend("force", opts.indent or {}, {
        char = "│",
        highlight = "IblIndent",
      })
      opts.scope = vim.tbl_deep_extend("force", opts.scope or {}, {
        enabled = true,
        show_start = true,
        show_end = true,
        show_exact_scope = true,
      })
      return opts
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
