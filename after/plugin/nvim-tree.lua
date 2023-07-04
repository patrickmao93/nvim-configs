-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

local function my_on_attach(bufnr)
    local api = require "nvim-tree.api"

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.set('n', '<leader>e', vim.cmd.NvimTreeToggle, {})
    vim.keymap.set('n', 'g?', api.tree.toggle_help, opts('Help'))
    vim.keymap.set('n', '<C-f>', vim.cmd.NvimTreeFindFile, {})
end

-- empty setup using defaults
-- require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
    sort_by = "case_sensitive",
    view = {
        width = 40,
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = true,
    },
    on_attach = my_on_attach
})
