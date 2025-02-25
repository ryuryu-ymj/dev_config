-- Treesitter
return {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    -- event = "BufReadPost",
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
        -- Show initial line of function, etc.
        {
            'nvim-treesitter/nvim-treesitter-context',
            config = function()
                require('treesitter-context').setup {
                    max_lines = 2
                }
            end
        },
    },
    config = function()
        require('nvim-treesitter.configs').setup {
            -- A list of parser names
            ensure_installed = { "vim", "lua", "markdown", "python", "c", "rust", "fish", "html", "css", "javascript", "typescript" },
            highlight = {
                enable = true,
            },

            indent = {
                enable = true,
            },

            textobjects = {
                select = {
                    enable = true,
                    -- Automatically jump forward to textobj, similar to targets.vim
                    lookahead = true,
                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                        ["aa"] = "@parameter.outer",
                        ["ia"] = "@parameter.inner",
                        -- You can optionally set descriptions to the mappings (used in the desc parameter of
                        -- nvim_buf_set_keymap) which plugins like which-key display
                        -- ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                    },
                    -- You can choose the select mode (default is charwise 'v')
                    --
                    -- Can also be a function which gets passed a table with the keys
                    -- * query_string: eg '@function.inner'
                    -- * method: eg 'v' or 'o'
                    -- and should return the mode ('v', 'V', or '<c-v>') or a table
                    -- mapping query_strings to modes.
                    -- selection_modes = {
                    -- ['@parameter.outer'] = 'v', -- charwise
                    -- ['@function.outer'] = 'V', -- linewise
                    -- ['@class.outer'] = '<c-v>', -- blockwise
                    -- },
                    -- If you set this to `true` (default is `false`) then any textobject is
                    -- extended to include preceding or succeeding whitespace. Succeeding
                    -- whitespace has priority in order to act similarly to eg the built-in
                    -- `ap`.
                    --
                    -- Can also be a function which gets passed a table with the keys
                    -- * query_string: eg '@function.inner'
                    -- * selection_mode: eg 'v'
                    -- and should return true of false
                    include_surrounding_whitespace = true,
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ["<Leader>an"] = "@parameter.inner",
                    },
                    swap_previous = {
                        ["<Leader>ap"] = "@parameter.inner",
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        ["]m"] = "@function.outer",
                        ["]]"] = { query = "@class.outer", desc = "Next class start" },
                    },
                    goto_next_end = {
                        ["]M"] = "@function.outer",
                        ["]["] = "@class.outer",
                    },
                    goto_previous_start = {
                        ["[m"] = "@function.outer",
                        ["[["] = "@class.outer",
                    },
                    goto_previous_end = {
                        ["[M"] = "@function.outer",
                        ["[]"] = "@class.outer",
                    },
                    -- Below will go to either the start or the end, whichever is closer.
                    -- Use if you want more granular movements
                    -- Make it even more gradual by adding multiple queries and regex.
                    goto_next = {
                        ["]d"] = "@conditional.outer",
                    },
                    goto_previous = {
                        ["[d"] = "@conditional.outer",
                    }
                },
            },

            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-s>",
                    node_incremental = "<C-s>",
                    -- scope_incremental = "grc",
                    -- node_decremental = "grm",
                },
            },
        }
    end,
}
