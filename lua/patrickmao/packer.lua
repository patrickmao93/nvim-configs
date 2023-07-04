-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")

    use({
        "nvim-telescope/telescope.nvim",
        tag = "0.1.2",
        requires = { { "nvim-lua/plenary.nvim" } },
    })

    use({ "rktjmp/lush.nvim" })
    use({ "rose-pine/neovim", as = "rose-pine" })
    use({ "briones-gabriel/darcula-solid.nvim", requires = "rktjmp/lush.nvim" })
    use({ "projekt0n/github-nvim-theme" })
    use("rebelot/kanagawa.nvim")

    use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })

    use("mbbill/undotree")

    use({
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        requires = {
            -- LSP Support
            { "neovim/nvim-lspconfig" }, -- Required
            {                            -- Optional
                "williamboman/mason.nvim",
                run = function()
                    pcall(vim.cmd, "MasonUpdate")
                end,
            },
            { "williamboman/mason-lspconfig.nvim" }, -- Optional

            -- Autocompletion
            { "hrsh7th/nvim-cmp" },     -- Required
            { "hrsh7th/cmp-nvim-lsp" }, -- Required
            { "L3MON4D3/LuaSnip" },     -- Required
        },
    })
    use {
        'filipdutescu/renamer.nvim',
        branch = 'master',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use({
        "nvim-tree/nvim-tree.lua",
        requires = {
            "nvim-tree/nvim-web-devicons", -- optional
        },
    })

    use({ "mhartington/formatter.nvim", run = "cargo install stylua" }) -- lua formatter

    use({
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    })

    use({
        "ruifm/gitlinker.nvim",
        requires = "nvim-lua/plenary.nvim",
    })

    use({
        "Shatur/neovim-session-manager",
        requires = "nvim-lua/plenary.nvim",
    })

    use({ "catppuccin/nvim", as = "catppuccin" })

    use({
        "nvim-lualine/lualine.nvim",
        requires = { "nvim-tree/nvim-web-devicons", opt = true },
    })

    use 'ThePrimeagen/harpoon'
end)
