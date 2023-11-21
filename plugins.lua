local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

	-- Override plugin definition options

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- format & linting
			{
				"jose-elias-alvarez/null-ls.nvim",
				config = function()
					require("custom.configs.null-ls")
				end,
			},
		},
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end, -- Override to setup mason-lspconfig
	},

	-- override plugin configs
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"eslint-lsp",
				"typescript-language-server",
				"gopls",
				"black",
				"debugpy",
				"mypy",
				"ruff",
				"pyright",
			},
		},
	},

	{
		"nvim-treesitter/nvim-treesitter",
		opts = overrides.treesitter,
	},

	{
		"nvim-tree/nvim-tree.lua",
		opts = overrides.nvimtree,
	},

	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},

	-- Install a plugin
	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		config = function()
			require("better_escape").setup()
		end,
	},

	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		event = "LspAttach",
		config = function()
			require("lsp_lines").setup()
		end,
	},

	{
		"kdheepak/lazygit.nvim",
		cmd = "LazyGit",
	},

	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		build = ":Copilot auth",
		opts = {
			suggestion = {
				enabled = true,
				auto_trigger = true,
				keymap = { accept = "<Tab>" },
			},
			panel = { enabled = false },
			filetypes = {
				markdown = true,
				help = true,
			},
		},
	},

	-- To make a plugin not be loaded
	{
		"NvChad/nvim-colorizer.lua",
		enabled = false,
	},

	-- All NvChad plugins are lazy-loaded by default
	-- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
	-- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
	{
		"mg979/vim-visual-multi",
		keys = {
			"<C-n>",
			"<C-N>",
			"<M-n>",
			"<S-Down>",
			"<S-Up>",
			"<M-Left>",
			"<M-i>",
			"<M-Right>",
			"<M-D>",
			"<M-Down>",
			"<C-d>",
			"<C-Down>",
			"<C-Up>",
			"<S-Right>",
			"<C-LeftMouse>",
			"<M-LeftMouse>",
			"<M-C-RightMouse>",
		},
		lazy = true,
		cond = function()
			return not vim.g.vscode
		end,
		init = function()
			vim.g.VM_mouse_mappings = 1
			vim.g.VM_silent_exit = 0
			vim.g.VM_show_warnings = 1
			vim.g.VM_default_mappings = 1

			vim.cmd([[
    let g:VM_maps = {}
    let g:VM_maps["Find Under"] = '<C-b>'
  ]])
		end,
	},
}

return plugins
