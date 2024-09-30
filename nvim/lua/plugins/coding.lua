return {
    -- Snipet engine
    -- {
    --     'L3MON4D3/LuaSnip',
    --     keys = {
    --         {
    --             '<C-i>',
    --             function()
    --                 local snip = require('luasnip')
    --                 if snip.jumpable(1) then
    --                     snip.jump(1)
    --                 else
    --
    --                 end
    --             end,
    --             mode = { "i", "s" }
    --         },
    --         {
    --             '<C-k>',
    --             function()
    --                 require('luasnip').jump(-1)
    --             end,
    --             mode = { "i", "s" }
    --         },
    --     },
    --     config = function()
    --         require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
    --     end
    -- },

    -- Completion
    {
        'hrsh7th/nvim-cmp',
        version = false, -- last release is way too old
        event = { "InsertEnter", "CmdlineEnter" },
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')

            cmp.setup({
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        luasnip.lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                window = {
                    -- completion = cmp.config.window.bordered(),
                    -- documentation = cmp.config.window.bordered(),
                },
                mapping = {
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-c>'] = cmp.mapping.abort(),
                    ['<C-j>'] = cmp.mapping.confirm { select = true },
                    -- ['<C-j>'] = cmp.mapping(function ()
                    --     if luasnip.expand_or_jumpable() then
                    --         luasnip.expand_or_jump()
                    --     else
                    --         cmp.confirm{ select = true }
                    --     end
                    -- end),
                    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                    ['<C-m>'] = cmp.mapping.scroll_docs(4),
                    ['<C-o>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-i>'] = cmp.mapping(function(fallback)
                        local snip = require('luasnip')
                        if snip.jumpable(1) then
                            snip.jump(1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<C-k>'] = cmp.mapping(function(fallback)
                        local snip = require('luasnip')
                        if snip.jumpable(-1) then
                            snip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                },
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    -- { name = 'vsnip' }, -- For vsnip users.
                    { name = 'luasnip' }, -- For luasnip users.
                    -- { name = 'ultisnips' }, -- For ultisnips users.
                    -- { name = 'snippy' }, -- For snippy users.
                    -- { name = 'omni' },
                }, {
                    { name = 'buffer' },
                    -- { name = 'path' },
                }, {
                    {
                        name = 'dictionary',
                        keyword_length = 4,
                    },
                })
            })

            -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline({ '/', '?' }, {
                mapping = {
                    ['<Tab>'] = {
                        c = function()
                            if cmp.visible() then
                                cmp.select_next_item()
                            end
                        end
                    },
                    ['<S-Tab>'] = {
                        c = function()
                            if cmp.visible() then
                                cmp.select_prev_item()
                            end
                        end
                    },
                },
                sources = {
                    { name = 'buffer' }
                },
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
                mapping = {
                    ['<Tab>'] = {
                        c = function(fallback)
                            if cmp.visible() then
                                cmp.select_next_item()
                            else
                                fallback()
                            end
                        end
                    },
                    ['<S-Tab>'] = {
                        c = function(fallback)
                            if cmp.visible() then
                                cmp.select_prev_item()
                            else
                                fallback()
                            end
                        end
                    },
                },
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    { name = 'cmdline' }
                })
            })
        end,
    },
    -- Completion sources
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'saadparwaiz1/cmp_luasnip',
    {
        'uga-rosa/cmp-dictionary',
        config = function()
            local dict = require('cmp_dictionary')
            dict.setup {
                paths = { vim.fn.stdpath('config') .. '/dict/en.dict' },
                exact_length = 4,
                first_case_insensitive = true,
                -- max_number_items = 16,
            }
        end
    },
    -- snipet engine
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

