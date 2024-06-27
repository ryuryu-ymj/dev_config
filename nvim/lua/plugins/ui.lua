return {
    -- Colorscheme
    {
        'ellisonleao/gruvbox.nvim',
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            vim.cmd([[colorscheme gruvbox]])
        end,
    },

    -- Better vim.ui
    {
        "stevearc/dressing.nvim",
        lazy = true,
        init = function()
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.select = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.select(...)
            end
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.input = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.input(...)
            end
        end,
    },

    -- Status line
    {
        'nvim-lualine/lualine.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons',
        event = 'VeryLazy',
        config = function()
            require('lualine').setup {
                options = {
                    theme = 'gruvbox',
                    section_separators = '',
                    component_separators = ''
                },
            }
        end
    },

    -- Buffer line
    {
        'akinsho/bufferline.nvim',
        -- version = "v3.*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        event = 'BufAdd',
        config = function()
            require("bufferline").setup {}

            -- 左右キーでバッファ間の移動
            vim.keymap.set('n', '<Left>', '<Cmd>BufferLineCyclePrev<CR>')
            vim.keymap.set('n', '<Right>', '<Cmd>BufferLineCycleNext<CR>')
            vim.keymap.set('i', '<Left>', '<Cmd>BufferLineCyclePrev<CR>')
            vim.keymap.set('i', '<Right>', '<Cmd>BufferLineCycleNext<CR>')
            -- Shift+左右キーでバッファを移動
            vim.keymap.set('n', '<S-Left>', '<Cmd>BufferLineMovePrev<CR>')
            vim.keymap.set('n', '<S-Right>', '<Cmd>BufferLineMoveNext<CR>')
            vim.keymap.set('i', '<S-Left>', '<Cmd>BufferLineMovePrev<CR>')
            vim.keymap.set('i', '<S-Right>', '<Cmd>BufferLineMoveNext<CR>')
        end
    }
}
