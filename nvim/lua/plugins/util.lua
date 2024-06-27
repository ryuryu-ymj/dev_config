return {
    -- Startup timer
    {
        'dstein64/vim-startuptime',
        cmd = 'StartupTime',
        config = function ()
            vim.g.startuptime_tries = 5
        end,
    },

    {
        'goolord/alpha-nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('alpha').setup(require('alpha.themes.startify').config)
        end
    }
}
