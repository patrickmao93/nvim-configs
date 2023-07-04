local lsp = require("lsp-zero").preset({})

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({
        buffer = bufnr,
        preserve_mappings = true,
    })
    lsp.buffer_autoformat()
end)

-- (Optional) Configure lua language server for neovim
local lspconfig = require("lspconfig")
lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
lspconfig.gopls.setup({
    settings = {
        gopls = {
            completeUnimported = true,
        },
    },
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
        vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
    end,
})

lsp.setup()

vim.o.updatetime = 250
vim.cmd([[autocmd! CursorHold * lua vim.diagnostic.open_float(nil, {focus=false})]])
