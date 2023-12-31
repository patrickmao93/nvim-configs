local dap = require('dap')

dap.set_log_level('INFO') -- Helps when configuring DAP, see logs with :DapShowLog

dap.configurations = {
    go = {
        {
            type = "go",         -- Which adapter to use
            name = "Debug",      -- Human readable name
            request = "launch",  -- Whether to "launch" or "attach" to program
            program = "${file}", -- The buffer you are focused on when running nvim-dap
        },
        {
            type = "go",
            name = "Debug test (go.mod)",
            request = "launch",
            mode = "test",
            program = "./${relativeFileDirname}",
        },
    }
}

dap.adapters.go = {
    type = "server",
    port = "${port}",
    executable = {
        command = vim.fn.stdpath("data") .. '/mason/bin/dlv',
        args = { "dap", "-l", "127.0.0.1:${port}" },
    },
}

local ui = require('dapui')
ui.setup()
ui.setup({
    icons = { expanded = "▾", collapsed = "▸" },
    mappings = {
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
    },
    expand_lines = vim.fn.has("nvim-0.7"),
    layouts = {
        {
            elements = {
                "scopes",
            },
            size = 0.2,
            position = "left"
        },
        {
            elements = {
                "repl",
            },
            size = 0.3,
            position = "bottom",
        },
    },
    floating = {
        max_height = nil,
        max_width = nil,
        border = "single",
        mappings = {
            close = { "q", "<Esc>" },
        },
    },
    windows = { indent = 1 },
    render = {
        max_type_length = nil,
    },
})

vim.keymap.set("n", "<leader>du", ui.toggle)

vim.fn.sign_define('DapBreakpoint', { text = '⭕' })

-- Start debugging session
vim.keymap.set("n", "<leader>ds", function()
    dap.continue()
    vim.cmd [[:NvimTreeClose]]
    ui.open({})
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false) -- Spaces buffers evenly
end)

-- Set breakpoints, get variable values, step into/out of functions, etc.
vim.keymap.set("n", "<leader>dh", require("dap.ui.widgets").hover)
vim.keymap.set("n", "<leader>dc", dap.continue)
vim.keymap.set("n", "<leader>dl", function()
    vim.cmd [[:NvimTreeClose]]
    ui.open({})
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false) -- Spaces buffers evenly
    dap.run_last()
end)
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>dn", dap.step_over)
vim.keymap.set("n", "<leader>di", dap.step_into)
vim.keymap.set("n", "<leader>do", dap.step_out)
vim.keymap.set("n", "<leader>dr", dap.repl.open)
vim.keymap.set("n", "<leader>dC", function()
    dap.clear_breakpoints()
    require("notify")("Breakpoints cleared", "warn")
end)

-- Close debugger and clear breakpoints
vim.keymap.set("n", "<leader>de", function()
    -- dap.clear_breakpoints()
    ui.close({})
    dap.terminate()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false)
    require("notify")("Debugger session ended", "warn")
end)
vim.keymap.set("n", "<leader>dt", dap.terminate)
