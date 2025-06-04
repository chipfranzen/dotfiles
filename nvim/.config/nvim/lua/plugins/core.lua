return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("catppuccin")
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
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("nvim-treesitter.configs").setup({
				branch = "master",
				lazy = false,
				ensure_installed = {
					"lua",
					"bash",
					"vim",
					"markdown",
					"markdown_inline",
					"json",
					"yaml",
					"toml",
					"python",
				},
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
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
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		lazy = false,
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
}
