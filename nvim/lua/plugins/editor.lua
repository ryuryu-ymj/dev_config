local function ts_builtin(func_name)
    return function()
        require('telescope.builtin')[func_name]()
    end
end

return {
    -- Show indent vertical line
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

    -- Show git signs at the left column
    {
        'lewis6991/gitsigns.nvim',
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            signs = {
                add = { text = "▎" },
                change = { text = "░" },
                delete = { text = "" },
                topdelete = { text = "" },
                changedelete = { text = "░" },
                untracked = { text = "▎" },
            },
        },
    },

    -- better diagnostics list and others
    {
        "folke/trouble.nvim",
        opts = {
            modes = {
                my_lsp_references = {
                    desc = "custom lsp references",
                    mode = "lsp_references",
                    auto_close = true,
                    auto_jump = true,
                    focus = true,
                    restore = false,
                    keys = {
                        ["<cr>"] = "jump_close",
                        ["<esc>"] = "close",
                    },
                    params = {
                        include_current = true,
                        include_declaration = false,
                    },
                },
                my_lsp_definitions = {
                    desc = "custom lsp definitions",
                    mode = "lsp_definitions",
                    auto_close = true,
                    auto_jump = true,
                    focus = true,
                    restore = false,
                    keys = {
                        ["<cr>"] = "jump_close",
                        ["<esc>"] = "close",
                    },
                    params = {
                        include_current = true,
                        include_declaration = false,
                    },
                },
            },
        },
        cmd = "Trouble",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
            -- {
            --     "gr",
            --     "<cmd>Trouble references <cr>",
            --     desc = "Diagnostics (Trouble)",
            -- },
        },
    },

    -- Show code outline
    -- {
    --     'simrat39/symbols-outline.nvim',
    --     cmd = {
    --         'SymbolsOutline',
    --         'SymbolsOutlineOpen',
    --         'SymbolsOutlineClose',
    --     },
    --     config = function()
    --         require("symbols-outline").setup()
    --     end
    -- },

    -- Fuzzy finder
    {
        'nvim-telescope/telescope.nvim',
        -- version = '0.1.1',
        dependencies = { 'nvim-lua/plenary.nvim' },
        cmd = 'Telescope',
        keys = {
            { '<Leader>ft',      '<Cmd>Telescope<CR>' },
            { '<Leader>ff',      ts_builtin('find_files') },
            { '<Leader><space>', ts_builtin('find_files') },
            { '<Leader>fo',      ts_builtin('oldfiles') },
            { '<Leader>fh',      ts_builtin('help_tags') },
        },
        config = function()
            require('telescope').setup {
                defaults = {
                    layout_strategy = 'flex',
                    layout_config = {
                        flex = {
                            flip_columns = 100,
                        },
                        vertical = {
                            height = { padding = 1 },
                            width = { padding = 4 },
                            preview_cutoff = 24,
                        },
                        horizontal = {
                            height = { padding = 1 },
                            width = { padding = 4 },
                            preview_width = 0.5,
                            preview_cutoff = 0,
                        },
                    },
                    mappings = {
                        i = {
                            ['<Esc>'] = require('telescope.actions').close,
                            ['<C-u>'] = false,
                            ["<C-d>"] = false,
                        },
                    },
                    path_display = {
                        "truncate",
                    },
                },
            }

            -- To get fzf loaded and working with telescope, you need to call
            -- load_extension, somewhere after setup function:
            require('telescope').load_extension('fzf')
        end,
    },
    -- Telescopeでソートにfzfを使う拡張機能
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        lazy = "true",
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release',
    },
}
