local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

-- faulty lint error don't fix
local lspconfig = require "lspconfig"
local util = require "lspconfig/util"

-- golang fm stufff
lspconfig.gopls.setup {
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
}
-- setup lsp for css html ts and tsx files
local servers = { "cssls", "html", "tsserver", "pyright" }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
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
