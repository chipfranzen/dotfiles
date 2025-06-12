return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },

  {
    "EdenEast/nightfox.nvim",
    name = "nightfox",
    priority = 1000,
    -- config = function()
    --   vim.cmd.colorscheme("nightfox")
    -- end,
  },

  { "tpope/vim-fugitive" },
  { "tpope/vim-repeat" },
  { "alexghergh/nvim-tmux-navigation" },

  {
    "norcalli/nvim-colorizer.lua",
    lazy = false,
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy", -- load after startup
    config = function()
      require("which-key").setup({
        -- you can add config options here later if needed
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        branch = "master",
        lazy = false,
        ensure_installed = {
          "bash",
          "diff",
          "gitcommit",
          "json",
          "lua",
          "markdown",
          "markdown_inline",
          "python",
          "toml",
          "vim",
          "yaml",
        },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { "gitcommit" },
        },
        indent = {
          enable = true,
        },
      })
    end,
  },

  {
    "HiPhish/rainbow-delimiters.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },

  {
    "kylechui/nvim-surround",
    version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file tree" } },
      { "<leader>o", "<cmd>NvimTreeFocus<cr>", { desc = "Focus file tree" } },
      { "<leader>r", "<cmd>NvimTreeFindFile<cr>", { desc = "Reveal file in tree" } },
    },
    config = function()
      require("nvim-tree").setup({
        diagnostics = { enable = false },
        git = { enable = false },
        update_focused_file = { enable = true },
        view = {
          width = 20,
        },
      })
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = vim.fn.executable("make") == 1,
      },
    },
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          layout_config = { prompt_position = "top" },
          sorting_strategy = "ascending",
          winblend = 10,
        },
      })
      pcall(require("telescope").load_extension, "fzf")
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = { theme = "catpuccin" },
  },

  {
    "cappyzawa/trim.nvim",
    config = function()
      require("trim").setup({
        trim_on_write = true,
        trim_trailing_lines = true,
        -- Disable when multiple cursors are active
        disable_in_multi_cursor = true,
        -- Don't show notifications when trimming
        highlight_on_trim = false,
      })
    end,
  },

  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({
        options = {
          numbers = "none",
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              highlight = "Directory",
              separator = true,
            },
          },
          show_buffer_icons = true,
          show_buffer_close_icons = true,
          separator_style = "slant",
        },
      })
      vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { silent = true })
      vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { silent = true })
    end,
  },

  {
    "stevearc/oil.nvim",
    opts = {},
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
    lazy = false,
    cmd = "Oil",
    keys = {
      { "-", "<CMD>Oil<CR>", { desc = "Open parent directory" } },
    },
  },
}
