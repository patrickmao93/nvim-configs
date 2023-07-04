require("harpoon").setup({
    menu = {
        width = math.floor(vim.api.nvim_win_get_width(0) * 3 / 4),
    }
})

local hu = require('harpoon.ui')
local hm = require('harpoon.mark')

vim.keymap.set("n", "<leader>hp", hu.toggle_quick_menu)
vim.keymap.set("n", "<leader>ha", hm.add_file)
vim.keymap.set("n", "<C-.>", hu.nav_next)
vim.keymap.set("n", "<C-,>", hu.nav_prev)
