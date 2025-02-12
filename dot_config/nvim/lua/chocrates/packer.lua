-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use({
        'sainnhe/everforest',
        as = 'everforest',
        config = function()
            vim.cmd('colorscheme everforest')
        end
    })

    use('nvim-treesitter/nvim-treesitter', {
        run = ':TSUpdate',
        config = function()
            require("nvim-treesitter.configs").setup {
                highlight = {
                    enable = true,
                },
                ensure_installed = {
                    "vimdoc",
                    "luadoc",
                    "vim",
                    "lua",
                    "markdown"
                }
            }
        end,
    })

    use('nvim-treesitter/playground')

    use('ThePrimeagen/harpoon')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {                            -- Optional
                'williamboman/mason.nvim',
                run = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-cmdline" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-nvim-lua" },
            { "saadparwaiz1/cmp_luasnip" },
            {
                "petertriho/cmp-git",
                requires = {
                    "nvim-lua/plenary.nvim",
                },
            },
            {
                "zbirenbaum/copilot-cmp",
                requires = {
                    "zbirenbaum/copilot.lua",
                    cmd = "Copilot",
                    event = "InsertEnter",
                    config = function()
                        require("copilot").setup({
                            suggestion = { enabled = false },
                            panel = { enabled = false },
                        })
                    end,
                },
                config = function()
                    require("copilot_cmp").setup()
                end,
            },
            {
                "L3MON4D3/LuaSnip",
                requires = {
                    {
                        "rafamadriz/friendly-snippets",
                        config = function()
                            require("luasnip.loaders.from_vscode").lazy_load()
                            require("luasnip").filetype_extend("ruby", { "rails" })
                        end,
                    },
                },
            },


        }

    }
    use('nvim-tree/nvim-tree.lua')
    use('nvim-tree/nvim-web-devicons')
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }

    use("github/copilot")

    use('mrtazz/vim-plan')

    use { 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async' }

    use {
        'pwntester/octo.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
        },
        config = function()
            require "octo".setup()
        end
    }

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    use("lbrayner/vim-rzip")

    use { "mxsdev/nvim-dap-vscode-js", requires = { "mfussenegger/nvim-dap" } }
    use {
        "microsoft/vscode-js-debug",
        opt = true,
        run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
    }

    use 'ray-x/go.nvim'
    use 'ray-x/guihua.lua' -- recommended if need floating window support

end)
