local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")

local b = null_ls.builtins

local sources = {
	b.diagnostics.eslint_d.with({
		diagnostics_format = "[eslint] #{m}\n(#{c})",
	}),
	-- webdev stuff
	b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
	b.formatting.prettier.with({
		filetypes = {
			"html",
			"markdown",
			"css",
			"javascript",
			"typescript",
			"javascriptreact",
			"typescriptreact",
			"json",
			"scss",
			"less",
		},
	}),

	-- Lua
	b.formatting.stylua,

	-- cpp
	b.formatting.clang_format,
	-- Golang
	b.formatting.gofumpt,
	b.formatting.goimports_reviser,
	b.formatting.golines,
	-- Python
	b.formatting.black,
	b.diagnostics.mypy,
	b.diagnostics.ruff,
}

-- format on save bs for null-ls
null_ls.setup({
	debug = true,
	sources = sources,
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({
				group = augroup,
				buffer = bufnr,
			})
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
})
