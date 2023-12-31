local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")
local util = require("lspconfig/util")

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "clangd" }

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

local function organize_imports()
	local params = {
		command = "_typescript.organizeImports",
		arguments = { vim.api.nvim_buf_get_name(0) },
	}
	vim.lsp.buf.execute_command(params)
end

-- golang fm stufff
lspconfig.gopls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_dir = util.root_pattern("go.work", "go.mod", ".git"),
	settings = {
		gopls = {
			completeunimported = true,
			useplaceholders = true,
			analyses = {
				unusedparans = true,
			},
		},
	},
})

lspconfig.tsserver.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	init_options = {
		preferences = {
			disableSuggestions = true,
		},
	},
	commands = {
		OrganizeImports = {
			organize_imports,
			description = "Organize Imports",
		},
	},
})

lspconfig.pyright.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "python" },
})

-- ------------------ activate giving your needs, not all tested ------------
-- setup lsp for json files
-- lspconfig.jsonls.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   commands = {
--     format = {
--       function()
--         vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
--       end,
--     },
--   },
-- }
--
-- -- setup lsp for vim files
-- lspconfig.vimls.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   filetypes = { "vim" },
-- }
--
-- -- setup lsp for yaml files
-- lspconfig.yamlls.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }
--
-- -- setup lsp for lua files
-- lspconfig.sumneko_lua.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   cmd = { "lua-language-server" },
--   settings = {
--     lua = {
--       diagnostics = {
--         globals = { "vim" },
--       },
--       workspace = {
--         library = {
--           [vim.fn.expand "$vimruntime/lua"] = true,
--           [vim.fn.expand "$vimruntime/lua/vim/lsp"] = true,
--         },
--       },
--     },
--   },
-- }
--
-- -- setup lsp for rust files
-- lspconfig.rust_analyzer.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }
--
-- -- setup lsp for java files
-- lspconfig.jdtls.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }
--
-- -- setup lsp for cpp files
-- lspconfig.clangd.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }
--
-- -- setup lsp for docker files
-- lspconfig.dockerls.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }
--
-- -- setup lsp for bash files
-- lspconfig.bashls.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }
--
-- -- setup lsp for vimwiki files
-- lspconfig.vimwiki.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }
