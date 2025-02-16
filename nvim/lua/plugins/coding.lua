return {
    -- Completion
    {
        'saghen/blink.cmp',
        version = '*',
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- 'default' for mappings similar to built-in completion
            -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
            -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
            -- See the full "keymap" documentation for information on defining your own keymap.
            keymap = {
                preset = 'none',

                ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
                ['<C-c>'] = { 'cancel', 'hide' },
                ['<C-j>'] = { 'select_and_accept', 'fallback' },

                ['<C-p>'] = { 'select_prev', 'fallback' },
                ['<C-n>'] = { 'select_next', 'fallback' },

                ['<C-o>'] = { 'scroll_documentation_up', 'fallback' },
                ['<C-m>'] = { 'scroll_documentation_down', 'fallback' },

                ['<C-i>'] = { 'snippet_forward', 'fallback' },
                ['<C-k>'] = { 'snippet_backward', 'fallback' },

                cmdline = {
                    preset = 'none',
                    ['<S-Tab>'] = { 'select_prev', 'fallback' },
                    ['<Tab>'] = { 'show', 'select_next', 'fallback' },
                },
            },

            appearance = {
                -- Sets the fallback highlight groups to nvim-cmp's highlight groups
                -- Useful for when your theme doesn't support blink.cmp
                -- Will be removed in a future release
                use_nvim_cmp_as_default = true,
                -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono'
            },

            snippets = {
                preset = 'luasnip',
            },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },

            completion = {
                list = {
                    selection = {
                        preselect = false,
                        auto_insert = true,
                    }
                },
            },

            signature = { enabled = true },
        },
        opts_extend = { "sources.default" }
    },
    -- Snippet engine
    {
        'L3MON4D3/LuaSnip',
        config = function()
            -- vim.api.nvim_set_hl(0, 'LuasnipInsertNodePassive', { link = 'GruvboxRedUnderline' })
            -- vim.api.nvim_set_hl(0, 'LuasnipInsertNodeActive', { link = 'GruvboxAquaUnderline' })

            require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })

            -- local types = require("luasnip.util.types")
            require("luasnip").setup({
                -- ext_opts = {
                --     [types.insertNode] = {
                --         active = {
                --             hl_group = "GruvboxAqua"
                --         },
                --         unvisited = {
                --             hl_group = "GruvboxRed"
                --         },
                --     },
                -- },
            })
        end
    },

    -- Add/delete/replace surroundings such as (), "".
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
                aliases = {
                }
            })
        end
    },

    -- Automatically close surroundings
    {
        "windwp/nvim-autopairs",
        event = "VeryLazy",
        config = function()
            local npairs = require('nvim-autopairs')
            npairs.setup()
            -- vim.keymap.set('i', '<C-h>', function()
            --     return npairs.autopairs_bs()
            -- end)

            local rule = require('nvim-autopairs.rule')
            local cond = require('nvim-autopairs.conds')

            npairs.add_rules({
                rule('$', '$', { "markdown", "tex", "typst" })
                    :with_pair(cond.not_after_regex('[^ \\t\\r\\n,.]', 1))
                    :with_move(function(opts)
                        return opts.next_char == opts.char
                    end),
                rule('(', ')', { "markdown", "tex", "typst" })
                    :with_pair(cond.after_text('$'))
                    :with_pair(cond.not_before_text('\\')),
                rule('{', '}', { "markdown", "tex", "typst" })
                    :with_pair(cond.after_text('$'))
                    :with_pair(cond.not_before_text('\\')),
                rule('[', ']', { "markdown", "tex", "typst" })
                    :with_pair(cond.after_text('$'))
                    :with_pair(cond.not_before_text('\\')),
            })
        end
    },

    -- Toggle comments
    {
        'numToStr/Comment.nvim',
        event = "VeryLazy",
        config = true,
    },

    {
        'NMAC427/guess-indent.nvim',
        config = true,
    },
}
