return {
    {
        "preservim/vim-markdown",
        version = false, -- last release is way too old
        ft = { 'markdown' },
        config = function()
            vim.g.vim_markdown_math = 1
            vim.g.vim_markdown_folding_disabled = 1

            local map_opts = { buffer = true }
            vim.keymap.set('i', 'mk', "$$<C-\\><C-N>i", map_opts)
            vim.keymap.set('i', 'dm', "$$\n\n$$<C-o>k", map_opts)

            vim.g.mkdp_markdown_css = vim.fn.stdpath('config') .. '/markdown.css'

            local imap_leader = "@"
            local imap_list = {
                { lhs = '0',  rhs = '\\emptyset' },
                { lhs = '6',  rhs = '\\partial' },
                { lhs = '8',  rhs = '\\infty' },
                { lhs = '=',  rhs = '\\equiv' },
                { lhs = '\\', rhs = '\\setminus' },
                { lhs = '.',  rhs = '\\cdot' },
                { lhs = '*',  rhs = '\\times' },
                { lhs = '<',  rhs = '\\langle' },
                { lhs = '>',  rhs = '\\rangle' },
                { lhs = 'H',  rhs = '\\hbar' },
                { lhs = '+',  rhs = '\\dagger' },
                { lhs = '[',  rhs = '\\subseteq' },
                { lhs = ']',  rhs = '\\supseteq' },
                { lhs = '(',  rhs = '\\subset' },
                { lhs = ')',  rhs = '\\supset' },
                { lhs = 'A',  rhs = '\\forall' },
                { lhs = 'E',  rhs = '\\exists' },
                { lhs = 'jj', rhs = '\\downarrow' },
                { lhs = 'jJ', rhs = '\\Downarrow' },
                { lhs = 'jk', rhs = '\\uparrow' },
                { lhs = 'jK', rhs = '\\Uparrow' },
                { lhs = 'jh', rhs = '\\leftarrow' },
                { lhs = 'jH', rhs = '\\Leftarrow' },
                { lhs = 'jl', rhs = '\\rightarrow' },
                { lhs = 'jL', rhs = '\\Rightarrow' },
                { lhs = 'a',  rhs = '\\alpha' },
                { lhs = 'b',  rhs = '\\beta' },
                { lhs = 'c',  rhs = '\\chi' },
                { lhs = 'd',  rhs = '\\delta' },
                { lhs = 'e',  rhs = '\\epsilon' },
                { lhs = 'f',  rhs = '\\phi' },
                { lhs = 'g',  rhs = '\\gamma' },
                { lhs = 'h',  rhs = '\\eta' },
                { lhs = 'i',  rhs = '\\iota' },
                { lhs = 'k',  rhs = '\\kappa' },
                { lhs = 'l',  rhs = '\\lambda' },
                { lhs = 'm',  rhs = '\\mu' },
                { lhs = 'n',  rhs = '\\nu' },
                { lhs = 'p',  rhs = '\\pi' },
                { lhs = 'q',  rhs = '\\theta' },
                { lhs = 'r',  rhs = '\\rho' },
                { lhs = 's',  rhs = '\\sigma' },
                { lhs = 't',  rhs = '\\tau' },
                { lhs = 'y',  rhs = '\\psi' },
                { lhs = 'u',  rhs = '\\upsilon' },
                { lhs = 'w',  rhs = '\\omega' },
                { lhs = 'z',  rhs = '\\zeta' },
                { lhs = 'x',  rhs = '\\xi' },
                { lhs = 'D',  rhs = '\\Delta' },
                { lhs = 'F',  rhs = '\\Phi' },
                { lhs = 'G',  rhs = '\\Gamma' },
                { lhs = 'L',  rhs = '\\Lambda' },
                { lhs = 'P',  rhs = '\\Pi' },
                { lhs = 'Q',  rhs = '\\Theta' },
                { lhs = 'S',  rhs = '\\Sigma' },
                { lhs = 'U',  rhs = '\\Upsilon' },
                { lhs = 'W',  rhs = '\\Omega' },
                { lhs = 'X',  rhs = '\\Xi' },
                { lhs = 'Y',  rhs = '\\Psi' },
                { lhs = 've', rhs = '\\varepsilon' },
                { lhs = 'vf', rhs = '\\varphi' },
                { lhs = 'vk', rhs = '\\varkappa' },
                { lhs = 'vq', rhs = '\\vartheta' },
                { lhs = 'vr', rhs = '\\varrho' },
            }

            for _, imap in pairs(imap_list) do
                vim.keymap.set('i', imap_leader .. imap.lhs, imap.rhs, map_opts)
            end
        end,
    },

    -- {
    --     'toppair/peek.nvim',
    --     build = 'deno task --quiet build:fast',
    --     config = function()
    --         require('peek').setup {
    --             syntax = false,
    --             app = { 'chrome.exe', '--new-window' },
    --         }
    --
    --         vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
    --         vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
    --     end,
    -- },

    -- {
    --     "iamcco/markdown-preview.nvim",
    --     build = "cd app && npm install",
    --     init = function()
    --         vim.g.mkdp_filetypes = { "markdown" }
    --     end,
    --     ft = { "markdown" },
    --     config = function()
    --         vim.cmd [[
    --         function! OpenMarkdownPreview(url)
    --             execute "silent ! chrome.exe --app=" .. a:url .. "&"
    --         endfunction
    --         ]]
    --         vim.g.mkdp_browserfunc = 'OpenMarkdownPreview'
    --         -- vim.g.mkdp_browser = '/mnt/c/Program Files/Google/Chrome/Application'
    --     end,
    -- },
}
