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
		end,
		opts = {
			inlay_hints = { enabled = true },
			servers = {
				cssls = {},
				tailwindcss = {
					root_dir = function(...)
						return require("lspconfig.util").root_pattern(".git")(...)
					end,
				},
				tsserver = {
					root_dir = function(...)
						return require("lspconfig.util").root_pattern(".git")(...)
					end,
					single_file_support = false,
					settings = {
						typescript = {
							inlayHints = {
								includeInlayParameterNameHints = "literal",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = false,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
						javascript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
					},
				},
				html = {},
				yamlls = {
					settings = {
						yaml = {
							keyOrdering = false,
						},
					},
				},
				lua_ls = {
					-- enabled = false,
					single_file_support = true,
					settings = {
						Lua = {
							workspace = {
								checkThirdParty = false,
							},
							completion = {
								workspaceWord = true,
								callSnippet = "Both",
							},
							misc = {
								parameters = {
									-- "--log-level=trace",
								},
							},
							hint = {
								enable = true,
								setType = false,
								paramType = true,
								paramName = "Disable",
								semicolon = "Disable",
								arrayIndex = "Disable",
							},
							doc = {
								privateName = { "^_" },
							},
							type = {
								castNumberToInteger = true,
							},
							diagnostics = {
								disable = { "incomplete-signature-doc", "trailing-space" },
								-- enable = false,
								groupSeverity = {
									strong = "Warning",
									strict = "Warning",
								},
								groupFileStatus = {
									["ambiguity"] = "Opened",
									["await"] = "Opened",
									["codestyle"] = "None",
									["duplicate"] = "Opened",
									["global"] = "Opened",
									["luadoc"] = "Opened",
									["redefined"] = "Opened",
									["strict"] = "Opened",
									["strong"] = "Opened",
									["type-check"] = "Opened",
									["unbalanced"] = "Opened",
									["unused"] = "Opened",
								},
								unusedLocalExclude = { "_*" },
							},
							format = {
								enable = false,
								defaultConfig = {
									indent_style = "space",
									indent_size = "2",
									continuation_indent_size = "2",
								},
							},
						},
					},
				},
			},
		},
		{
			"simrat39/symbols-outline.nvim",
			keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
			cmd = "SymbolsOutline",
			opts = {
				position = "right",
			},
		},
		{
			"echasnovski/mini.bracketed",
			event = "BufReadPost",
			config = function()
				local bracketed = require("mini.bracketed")
				bracketed.setup({
					file = { suffix = "" },
					window = { suffix = "" },
					quickfix = { suffix = "" },
					yank = { suffix = "" },
					treesitter = { suffix = "n" },
				})
			end,
		},
		{
			"folke/trouble.nvim",
			cmd = "TroubleToggle",
			opts = {
				auto_open = false,
				auto_close = true,
				auto_preview = false,
				auto_fold = false,
				use_lsp_diagnostic_signs = true,
			},
		},
		{
			"nvimdev/lspsaga.nvim",
			config = function()
				require("lspsaga").setup({})
			end,
		},
		{
			"echasnovski/mini.hipatterns",
			event = "BufReadPre",
			opts = {
				highlighters = {
					hsl_color = {
						pattern = "hsl%(%d+,? %d+,? %d+%)",
						group = function(_, match)
							local utils = require("solarized-osaka.hsl")
							local h, s, l = match:match("hsl%((%d+),? (%d+),? (%d+)%)")
							h, s, l = tonumber(h), tonumber(s), tonumber(l)
							local hex_color = utils.hslToHex(h, s, l)
							return MiniHipatterns.compute_hex_color_group(hex_color, "bg")
						end,
					},
				},
			},
		},

		{
			"folke/noice.nvim",
			opts = function(_, opts)
				table.insert(opts.routes, {
					filter = {
						event = "notify",
						find = "No information available",
					},
					opts = { skip = true },
				})
				local focused = true
				vim.api.nvim_create_autocmd("FocusGained", {
					callback = function()
						focused = true
					end,
				})
				vim.api.nvim_create_autocmd("FocusLost", {
					callback = function()
						focused = false
					end,
				})
				table.insert(opts.routes, 1, {
					filter = {
						cond = function()
							return not focused
						end,
					},
					view = "notify_send",
					opts = { stop = false },
				})

				opts.commands = {
					all = {
						-- options for the message history that you get with `:Noice`
						view = "split",
						opts = { enter = true, format = "details" },
						filter = {},
					},
				}

				vim.api.nvim_create_autocmd("FileType", {
					pattern = "markdown",
					callback = function(event)
						vim.schedule(function()
							require("noice.text.markdown").keys(event.buf)
						end)
					end,
				})

				opts.presets.lsp_doc_border = true
			end,
		},

		{
			"rcarriga/nvim-notify",
			opts = {
				timeout = 5000,
			},
		},

		-- animations
		{
			"echasnovski/mini.animate",
			event = "VeryLazy",
			opts = function(_, opts)
				opts.scroll = {
					enable = false,
				}
			end,
		},
		{
			"nvim-lualine/lualine.nvim",
			event = "VeryLazy",
			opts = {
				options = {
					-- globalstatus = false,
					theme = "solarized_dark",
				},
			},
		},

		-- filename
		{
			"b0o/incline.nvim",
			dependencies = { "craftzdog/solarized-osaka.nvim" },
			event = "BufReadPre",
			priority = 1200,
			config = function()
				local colors = require("solarized-osaka.colors").setup()
				require("incline").setup({
					highlight = {
						groups = {
							InclineNormal = { guibg = colors.magenta500, guifg = colors.base04 },
							InclineNormalNC = { guifg = colors.violet500, guibg = colors.base03 },
						},
					},
					window = { margin = { vertical = 0, horizontal = 1 } },
					hide = {
						cursorline = true,
					},
					render = function(props)
						local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
						if vim.bo[props.buf].modified then
							filename = "[+] " .. filename
						end

						local icon, color = require("nvim-web-devicons").get_icon_color(filename)
						return { { icon, guifg = color }, { " " }, { filename } }
					end,
				})
			end,
		},

		{
			"folke/zen-mode.nvim",
			cmd = "ZenMode",
			opts = {
				plugins = {
					gitsigns = true,
					tmux = true,
					kitty = { enabled = false, font = "+2" },
				},
			},
			keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
		},

		{
			"craftzdog/solarized-osaka.nvim",
			lazy = true,
			priority = 1000,
			opts = function()
				return {
					transparent = true,
				}
			end,
		},
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
			"jose-elias-alvarez/null-ls.nvim",
			event = "VeryLazy",
			opts = function()
				return require("custom.configs.null-ls")
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

		{
			"mg979/vim-visual-multi",
			keys = {
				"<C-n>",
				"<C-N>",
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
    let g:VM_maps['Find Under'] = '<C-d>'
  ]])
			end,
		},
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
}

return plugins
