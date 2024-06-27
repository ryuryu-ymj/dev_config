vim.cmd([[
autocmd BufRead * autocmd FileType <buffer> ++once
\ if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif
]])

local id = vim.api.nvim_create_augroup( 'highlight_yank', {} )
vim.api.nvim_create_autocmd( 'TextYankPost', {
  group = id,
  callback = function()
    vim.highlight.on_yank { higroup='IncSearch', timeout=100 }
  end,
})
