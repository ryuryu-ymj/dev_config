-- ホイールのクリックによるペーストを無効化
vim.keymap.set({ '', '!' }, '<MiddleMouse>', '<Nop>')
-- Shift+ホイールで左右スクロール
vim.keymap.set({ '', '!' }, '<S-ScrollWheelUp>', '3zh')
vim.keymap.set({ '', '!' }, '<S-ScrollWheelDown>', '3zl')
-- Alt+h,j,k,lでウィンドウ間の移動
vim.keymap.set('n', '<A-h>', '<C-w>h')
vim.keymap.set('n', '<A-j>', '<C-w>j')
vim.keymap.set('n', '<A-k>', '<C-w>k')
vim.keymap.set('n', '<A-l>', '<C-w>l')
vim.keymap.set('i', '<A-h>', '<C-\\><C-N><C-w>h')
vim.keymap.set('i', '<A-j>', '<C-\\><C-N><C-w>j')
vim.keymap.set('i', '<A-k>', '<C-\\><C-N><C-w>k')
vim.keymap.set('i', '<A-l>', '<C-\\><C-N><C-w>l')
-- Alt+H,J,K,Lでウィンドウを移動
vim.keymap.set('n', '<A-H>', '<C-w>H')
vim.keymap.set('n', '<A-J>', '<C-w>J')
vim.keymap.set('n', '<A-K>', '<C-w>K')
vim.keymap.set('n', '<A-L>', '<C-w>L')
vim.keymap.set('i', '<A-H>', '<C-\\><C-N><C-w>H')
vim.keymap.set('i', '<A-J>', '<C-\\><C-N><C-w>J')
vim.keymap.set('i', '<A-K>', '<C-\\><C-N><C-w>K')
vim.keymap.set('i', '<A-L>', '<C-\\><C-N><C-w>L')
-- -- 左右キーでタブ間の移動
-- vim.keymap.set('n', '<Left>', '<C-Pageup>')
-- vim.keymap.set('n', '<Right>', '<C-Pagedown>')
-- vim.keymap.set('i', '<Left>', '<C-\\><C-N><C-Pageup>')
-- vim.keymap.set('i', '<Right>', '<C-\\><C-N><C-Pagedown>')
-- -- Shift+左右キーでタブを移動
-- vim.keymap.set('n', '<S-Left>', '<Cmd>-tabmove<CR>')
-- vim.keymap.set('n', '<S-Right>', '<Cmd>+tabmove<CR>')
-- vim.keymap.set('i', '<S-Left>', '<Cmd>-tabmove<CR>')
-- vim.keymap.set('i', '<S-Right>', '<Cmd>+tabmove<CR>')
-- <Leader>qでバッファを削除
vim.keymap.set('n', '<Leader>q', '<Cmd>bdelete<CR>')
vim.keymap.set('n', '<Leader>!', '<Cmd>bdelete!<CR>')
-- <Leader>wでバッファを保存
vim.keymap.set('n', '<Leader>w', '<Cmd>write<CR>')

-- ^, $の代わりにH, Lで行頭行末移動
vim.keymap.set({ 'n', 'x', 'o' }, 'H', '^')
vim.keymap.set({ 'n', 'x', 'o' }, 'L', '$')
-- insertモードでemacs風のキーバインド
vim.keymap.set('i', '<C-h>', '<BS>', { remap = true })
vim.keymap.set('i', '<C-j>', '<CR>', { remap = true })
vim.keymap.set('!', '<C-a>', '<C-o>^')
vim.keymap.set('i', '<C-e>', '<End>')
vim.keymap.set('i', '<C-d>', '<Delete>')
-- vim.keymap.set('i', '<C-k>', '<Esc>lDa')
vim.keymap.set('!', '<C-b>', '<Left>')
vim.keymap.set('!', '<C-f>', '<Right>')
vim.keymap.set('c', '<C-p>', '<Up>')
vim.keymap.set('c', '<C-n>', '<Down>')

-- 消去したときにレジスタを汚さない
vim.keymap.set({ 'n', 'x' }, 'd', '"_d')
vim.keymap.set('n', 'dd', '"_dd')
vim.keymap.set('n', 'D', '"_D')
vim.keymap.set({ 'n', 'x' }, 'x', '"_x')
vim.keymap.set({ 'n', 'x' }, 'c', '"_c')
vim.keymap.set('n', 'cc', '"_cc')
vim.keymap.set('n', 'C', '"_C')
-- カットにはsを用いる
vim.keymap.set({ 'n', 'x' }, 's', 'd')
vim.keymap.set('n', 'ss', 'dd')
vim.keymap.set('n', 'S', 'D')

-- gJでスペースなしの行結合
-- vim.keymap.set('n', 'gJ', function ()
--   vim.cmd[[substitute/\n\s*//]]
-- end)
vim.cmd [[
nnoremap <expr> gJ JointLinesWithNoSpaces()

function JointLinesWithNoSpaces(type = '') abort
  if a:type == ''
    set opfunc=JointLinesWithNoSpaces
    return 'g@l'
  endif
  substitute/\n\s*//
endfunction
]]

-- YでWindowsのクリップボードにコピー
vim.cmd [[
nnoremap <silent> Y :set opfunc=WslYankOperator<CR>g@
nmap <silent> YY Y_
nmap <silent> Yy Y_
vnoremap <silent> Y :<C-U>call WslYankOperator(visualmode(), 1)<CR>
command! -range Y call WslYankCommand(<line1>, <line2>)

function! WslYankOperator(type, ...) abort
  let sel_save = &selection
  let &selection = "inclusive"
  let reg_save = @@
  if a:0  " Invoked from Visual mode, use gv command.
    silent exe "normal! gvy"
  elseif a:type == 'line'
    silent exe "normal! '[V']y"
  else
    silent exe "normal! `[v`]y"
  endif
  call system('wclip', @@)
  let &selection = sel_save
  let @@ = reg_save
endfunction

function! WslYankCommand(line1, line2) abort
  let reg_save = @@
  exe a:line1 . ',' a:line2 'yank'
  call system('wclip', @@)
  echo (a:line2 - a:line1 + 1) . ' lines yanked into Windows Clipboard'
  let @@ = reg_save
endfunction
]]


-- Escの2回押しで検索ハイライト解除
vim.keymap.set('n', '<Esc><Esc>', '<Cmd>nohlsearch<CR>')
