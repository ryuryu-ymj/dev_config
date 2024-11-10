return {
    -- Lsp server manager
    {
        'williamboman/mason.nvim',
        cmd = "Mason",
        config = true,
    },
    {
        'williamboman/mason-lspconfig.nvim',
        config = true,
    },

    -- Configs for the LSP client
    {
        'neovim/nvim-lspconfig',
        -- event = { "BufReadPre", "BufNewFile" },
        config = function()
            -- Mappings.
            -- See `:help vim.diagnostic.*` for documentation on any of the below functions
            -- local opts = { noremap = true, silent = true, buffer = true }
            -- vim.keymap.set('n', '<Leader>dk', vim.diagnostic.open_float, opts)
            -- vim.keymap.set('n', 'g]', vim.diagnostic.goto_next, opts)
            -- vim.keymap.set('n', 'g[', vim.diagnostic.goto_prev, opts)
            -- vim.keymap.set('n', '<Leader>dl', vim.diagnostic.setloclist, opts)

            -- Set diagnostics signs
            local signs = { Error = "󰅙 ", Warn = "󰀦 ", Hint = "󰌶 ", Info = "󰋽 " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end

            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help,
                { border = "rounded" })

            -- Add additional capabilities supported by nvim-cmp
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local bufnr = args.buf
                    local client = vim.lsp.get_client_by_id(args.data.client_id)

                    -- 行番号の左にサインを表示する列を常に表示
                    vim.wo.signcolumn = 'yes'

                    -- Enable completion triggered by <c-x><c-o>
                    -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

                    -- Mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    local bufopts = { noremap = true, silent = true, buffer = bufnr }
                    vim.keymap.set('n', '<Leader>dk', vim.diagnostic.open_float, bufopts)
                    -- vim.keymap.set('n', '<Leader>dl', vim.diagnostic.setloclist, bufopts)
                    vim.keymap.set('n', '<Leader>dl', "<cmd>Trouble diagnostics toggle<cr>", bufopts)
                    vim.keymap.set('n', '<Leader>ds', "<cmd>Trouble symbols toggle focus=false<cr>", bufopts)
                    vim.keymap.set('n', 'g]', vim.diagnostic.goto_next, bufopts)
                    vim.keymap.set('n', 'g[', vim.diagnostic.goto_prev, bufopts)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
                    vim.keymap.set('n', 'gd', "<cmd>Trouble my_lsp_definitions <cr>", bufopts)
                    vim.keymap.set('n', 'gr', "<cmd>Trouble my_lsp_references <cr>", bufopts)
                    vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, bufopts)
                    vim.keymap.set('n', '<Leader>ac', vim.lsp.buf.code_action, bufopts)
                    vim.keymap.set('n', '<Leader>l', function() vim.lsp.buf.format { async = true } end, bufopts)
                    vim.keymap.set('n', '<Leader>w', function()
                        vim.lsp.buf.format()
                        vim.cmd.write()
                    end, bufopts)
                    -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
                    -- vim.keymap.set('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
                    -- vim.keymap.set('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
                    -- vim.keymap.set('n', '<Leader>wl', function()
                    --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    -- end, bufopts)
                    -- vim.keymap.set('n', '<Leader>D', vim.lsp.buf.type_definition, bufopts)

                    -- カーソル下の変数などをハイライト
                    if client.server_capabilities.documentHighlightProvider then
                        -- vim.cmd [[
                        -- hi! LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
                        -- hi! LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
                        -- hi! LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
                        -- ]]
                        vim.api.nvim_set_hl(0, 'LspReferenceRead', { bg = '#3c3836' })
                        vim.api.nvim_set_hl(0, 'LspReferenceText', { bg = '#3c3836' })
                        vim.api.nvim_set_hl(0, 'LspReferenceWrite', { bg = '#3c3836' })
                        vim.api.nvim_create_augroup('lsp_document_highlight', {
                            clear = false
                        })
                        vim.api.nvim_clear_autocmds({
                            buffer = bufnr,
                            group = 'lsp_document_highlight',
                        })
                        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                            group = 'lsp_document_highlight',
                            buffer = bufnr,
                            callback = vim.lsp.buf.document_highlight,
                        })
                        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                            group = 'lsp_document_highlight',
                            buffer = bufnr,
                            callback = vim.lsp.buf.clear_references,
                        })
                    end
                end
            })

            -- for python
            require('lspconfig')['jedi_language_server'].setup {
                capabilities = capabilities,
                init_options = {
                    completion = {
                        disableSnippets = true,
                    },
                }
            }
            require('lspconfig')['ruff'].setup {
                capabilities = capabilities,
                init_options = {
                    settings = {
                        lint = {
                            ignore = { "E741" },
                            extendSelect = { "W", "COM", "ICN" },
                        },
                    },
                },
            }
        end,
    },

    -- Show inlay hints
    {
        'lvimuser/lsp-inlayhints.nvim',
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require('lsp-inlayhints').setup()
            vim.api.nvim_create_augroup('LspAttach_inlayhints', {})
            vim.api.nvim_create_autocmd('LspAttach', {
                group = 'LspAttach_inlayhints',
                callback = function(args)
                    if not (args.data and args.data.client_id) then
                        return
                    end

                    local bufnr = args.buf
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    require('lsp-inlayhints').on_attach(client, bufnr, false)
                    vim.api.nvim_set_hl(0, 'LspInlayHint', { italic = true, fg = '#83a598', bg = '#3c3836' })
                end,
            })
        end
    },

    -- Show lsp progress at the right bottom corner
    {
        'j-hui/fidget.nvim',
        event = { "BufReadPre", "BufNewFile" },
        config = true,
    }
}
